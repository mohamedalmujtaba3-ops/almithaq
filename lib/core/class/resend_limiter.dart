import 'package:shared_preferences/shared_preferences.dart';

/// يتحكم بعدد مرات إعادة إرسال رمز التحقق ومدة الانتظار بينها.
/// يُستخدم نسخة منفصلة لكل رقم هاتف (key) حتى لا تتداخل المحاولات.
class ResendLimiter {
  // فترات الانتظار بالدقائق: 5 ثم 15 ثم 30 ثم ساعتين (وتبقى ساعتين بعدها)
  static const List<int> _cooldownsMinutes = [5, 15, 30, 120];

  final String phone;
  ResendLimiter(this.phone);

  String get _attemptsKey => 'resend_attempts_$phone';
  String get _lastSentKey => 'resend_last_sent_$phone';

  int _cooldownFor(int attempts) {
    if (attempts <= 0) return 0;
    final index = (attempts - 1).clamp(0, _cooldownsMinutes.length - 1);
    return _cooldownsMinutes[index];
  }

  /// كم ثانية متبقية قبل السماح بالإرسال؟ صفر = مسموح الآن
  Future<int> secondsRemaining() async {
    final prefs = await SharedPreferences.getInstance();
    final attempts = prefs.getInt(_attemptsKey) ?? 0;
    final lastSent = prefs.getInt(_lastSentKey) ?? 0;
    if (attempts == 0) return 0;

    final elapsedMs = DateTime.now().millisecondsSinceEpoch - lastSent;
    final requiredMs = _cooldownFor(attempts) * 60 * 1000;
    final remainingMs = requiredMs - elapsedMs;
    return remainingMs > 0 ? (remainingMs / 1000).ceil() : 0;
  }

  Future<bool> canResend() async => (await secondsRemaining()) == 0;

  /// Stream جاهز للعد التنازلي: يصدر القيمة كل ثانية حتى تصل للصفر.
  /// استخدمه مباشرة في الواجهة، فلا حاجة لأي منطق توقيت داخل الكونترولر.
  Stream<int> countdown() async* {
    int remaining = await secondsRemaining();
    yield remaining;
    while (remaining > 0) {
      await Future.delayed(const Duration(seconds: 1));
      remaining = remaining > 0 ? remaining - 1 : 0;
      yield remaining;
    }
  }

  /// نادِ هذه الدالة فور نجاح الإرسال (بعد استجابة الـ API بنجاح)
  Future<void> recordSend() async {
    final prefs = await SharedPreferences.getInstance();
    final attempts = (prefs.getInt(_attemptsKey) ?? 0) + 1;
    await prefs.setInt(_attemptsKey, attempts);
    await prefs.setInt(_lastSentKey, DateTime.now().millisecondsSinceEpoch);
  }

  /// نادِها بعد نجاح التحقق من الرمز لتصفير العداد لهذا الرقم
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_attemptsKey);
    await prefs.remove(_lastSentKey);
  }
}
