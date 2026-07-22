import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/data/datasource/auth/codeandpass/resetpassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {
  resetpassword();
  goToSuccessResetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());

  StatusRequest statusRequest = StatusRequest.none ;

  late TextEditingController password;
  late TextEditingController repassword;

  String? phone;

  @override
  resetpassword() {}

  @override
  goToSuccessResetPassword() async {
    if (password.text != repassword.text) {
      return Get.defaultDialog(
          title: "تنبيه", middleText: "كلمات المرور غير متطابقة");
    }

    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await resetPasswordData.postdata(phone!, password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.successResetpassword);
        } else {
          Get.defaultDialog(
              title: "خطأ", middleText: "أدخل كلمة مرور مختلفة");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {
      Get.snackbar("تنبيه", "تأكد من صحة البيانات");
    }
  }

  @override
  void onInit() {
    phone = Get.arguments['phone'];
    password = TextEditingController();
    repassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }
}
