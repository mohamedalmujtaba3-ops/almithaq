import 'dart:async';
import 'dart:io';

checkInternet() async {
  // return true;
  try {
    var result = await InternetAddress.lookup("google.com").timeout(const Duration(seconds: 10));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on TimeoutException {
    return false;
  } on SocketException catch (_) {
    return false;
  }
}
