import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/auth/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class EditProfileController extends GetxController {
  editData();
}

class EditProfileControllerImp extends EditProfileController {
  
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController phone;
  late TextEditingController city;

  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  ProfileData profileData = ProfileData(Get.find());



  @override
  editData() async {
    if (formstate.currentState!.validate()) {
      if(city.text.isEmpty || city.text == "" || city.text == "0") {
        return Get.snackbar("إختر المدينة", "حقل المدينة لا يمكن أن يترك فارغاً");
      }
      statusRequest = StatusRequest.loading;
      update();
      var response = await profileData.editProfileData(
          myServices.sharedPreferences.getString("id").toString(),
          username.text,
          password.text,
          phone.text, city.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          myServices.sharedPreferences.setString("username", username.text); // Update Shared Prefrence with the new data
          myServices.sharedPreferences.setString("phone", phone.text);
          myServices.sharedPreferences.setString("city", city.text);
          Get.defaultDialog(
              barrierDismissible: false,
              title: "نجاح",
              titleStyle: const TextStyle(
                  color: AppColor.primaryColor,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold),
              middleText: "تم التعديل",
              middleTextStyle:
                  const TextStyle(color: AppColor.grey2, letterSpacing: 0),
              buttonColor: AppColor.primaryColor,
              confirmTextColor: Colors.white,
              textConfirm: "تم",
              onConfirm: () {
                  Get.offAllNamed(AppRoute.homepage);
              },
              );
              
        } else {
          Get.defaultDialog(
              title: "خطأ",
              titleStyle: const TextStyle(
                  color: Colors.red,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold),
              middleText: "حدث خطأ ما",
              middleTextStyle:
                  const TextStyle(color: AppColor.grey2, letterSpacing: 0));
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }




  


  @override
  void onInit() {
    username = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    city = TextEditingController();
    username.text = myServices.sharedPreferences.getString("username").toString();
    phone.text = myServices.sharedPreferences.getString("phone").toString();
    city.text = myServices.sharedPreferences.getString("city").toString();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    phone.dispose();
    city.dispose();
    super.dispose();
  }
}
