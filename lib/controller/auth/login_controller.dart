import 'dart:async';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/auth/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController phone;
  late TextEditingController password;

  bool isshowpassword = true;

  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  // ── Rate-limit state ────────────────────────────────────────
  bool isRateLimited = false;
  int rateLimitSecondsLeft = 0;
  Timer? _countdownTimer;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  void _startCountdown(int seconds) {
    isRateLimited = true;
    rateLimitSecondsLeft = seconds;
    update();
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      rateLimitSecondsLeft--;
      if (rateLimitSecondsLeft <= 0) {
        isRateLimited = false;
        rateLimitSecondsLeft = 0;
        t.cancel();
      }
      update();
    });
  }

  String get rateLimitMessage {
    if (rateLimitSecondsLeft <= 0) return '';
    final mins = rateLimitSecondsLeft ~/ 60;
    final secs = rateLimitSecondsLeft % 60;
    if (mins > 0) {
      return 'تم تجاوز الحد المسموح. يرجى الانتظار $mins د ${secs}ث';
    }
    return 'تم تجاوز الحد المسموح. يرجى الانتظار ${secs}ث';
  }

  @override
  login() async {
    if (isRateLimited) {
      Get.defaultDialog(
        title: 'تنبيه',
        middleText: rateLimitMessage,
      );
      return;
    }
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postdata(phone.text, password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success" && response['ver'] == "no") {
            myServices.sharedPreferences
                .setString("id", response['data']['users_id'].toString());
            String userid = myServices.sharedPreferences.getString("id")!;
            myServices.sharedPreferences
                .setString("username", response['data']['users_name']);
            myServices.sharedPreferences
                .setString("phone", response['data']['users_phone'].toString());
            myServices.sharedPreferences
                .setString("city", response['data']['users_city'].toString());
            myServices.sharedPreferences.setString("step", "2");

            // Save JWT token
            if (response['token'] != null) {
              myServices.sharedPreferences
                  .setString("jwt_token", response['token'].toString());
            }

            FirebaseMessaging.instance.subscribeToTopic("users");
            FirebaseMessaging.instance.subscribeToTopic("users${userid}");
            
            Get.offNamed(AppRoute.homepage);
        } else if (response['status'] == "too_many_attempts") {
          final seconds = (response['retry_after_sec'] as num?)?.toInt() ?? 600;
          _startCountdown(seconds);
          Get.defaultDialog(
            title: 'تنبيه',
            middleText: rateLimitMessage,
          );
          statusRequest = StatusRequest.failure;
        } else {
          if (response['status'] == "success" && response['ver'] == "yes") {
            Get.offNamed(AppRoute.verfiyCodeSignUp, preventDuplicates: false, arguments: {
                "phone" : phone.text
              });
          } else {
              Get.defaultDialog(
                  title: "خطأ", titleStyle: const TextStyle(
                      color: Colors.red,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold), middleText: "خطأ برقم الهاتف أو كلمة المرور", middleTextStyle:
                      const TextStyle(color: AppColor.grey2, letterSpacing: 0)
              );
          }
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }




  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }


@override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword, preventDuplicates: false);
  }


  @override
  void onInit() {
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

}
