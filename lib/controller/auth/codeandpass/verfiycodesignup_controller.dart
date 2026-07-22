import 'dart:async';
import 'package:almithaq/core/class/resend_limiter.dart';
import 'package:almithaq/data/datasource/auth/codeandpass/verfiycodesignup.dart';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:get/get.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkCode();
  goToSuccessSignUp(String verfiyCodeSignUp);
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {

  VerfiyCodeSignUpData verfiyCodeSignUpData = VerfiyCodeSignUpData(Get.find());

  String? phone;
  late ResendLimiter resendLimiter;

  int remainingSeconds = 0;
  Timer? _ticker;

  Future<void> _startCountdown() async {
    _ticker?.cancel();
    remainingSeconds = await resendLimiter.secondsRemaining();
    update();
    if (remainingSeconds <= 0) return;
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds--;
      if (remainingSeconds <= 0) {
        remainingSeconds = 0;
        timer.cancel();
      }
      update();
    });
  }

  @override
  void onClose() {
    _ticker?.cancel();
    super.onClose();
  }

  StatusRequest statusRequest = StatusRequest.none ;

  @override
  checkCode() {}

  @override
  goToSuccessSignUp(verfiyCodeSignUp) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verfiyCodeSignUpData.postdata(phone!, verfiyCodeSignUp); 
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") { 
          Get.offNamed(AppRoute.successSignUp);
      } else {
        Get.defaultDialog(
            title: "خطأ",
            middleText: "رمز التحقق غير صحيح");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }


   reSend() async{
      if(!await resendLimiter.canResend()) return;
      statusRequest = StatusRequest.loading; 
      update() ; 
      var response = await verfiyCodeSignUpData.resendData(phone!);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          await resendLimiter.recordSend();
          await _startCountdown();
          Get.defaultDialog(
            title: "تم",
            middleText: "تمت إعادة إرسال الرمز"
          );
        } else {
          Get.defaultDialog(
            title: "خطأ",
            middleText: "حدث خطأ أثناء إعادة الإرسال"
          );
        }
      } else {
          Get.defaultDialog(
            title: "خطأ",
            middleText: "حدث خطأ أثناء إعادة الإرسال"
          );
        }
        update();
    }


    @override
    void onInit() {
      phone = Get.arguments['phone'];
      resendLimiter = ResendLimiter(phone!);
      _startCountdown();
      super.onInit();
    }

 
}
