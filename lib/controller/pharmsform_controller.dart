import 'dart:async';
import 'dart:io';
import 'package:almithaq/core/class/push_notification_service.dart';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/functions/uploadfile.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/checkout_date.dart';
import 'package:almithaq/data/model/sellersmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PharmsFormController extends GetxController {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  CheckoutData ordersData = CheckoutData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  late SellersModel sellersModel;

  MyServices myServices = Get.find();

  late TextEditingController notes;
  late TextEditingController medstext;
  late String address;
  late String lat;
  late String long;

  File? rousheta;


  chooseImage () async {
    rousheta = await imageUploadGallery();
    update();
  }


  addOrderText() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await ordersData.addPharmOrder(myServices.sharedPreferences.getString("id").toString(), medstext.text, notes.text, lat, long, address, myServices.sharedPreferences.getString("city").toString());
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          try {
            await PushNotificationService().sendNotificationTopic("delivery", "طلب دواء جديد", "طلب دواء جديد بالتطبيق كن اول من يقبل", "none", "refreshpharmsorders").timeout(const Duration(seconds: 60));
          } on TimeoutException {
            print('Timeout');
          } catch (e) {
            print('Error: $e');
          }
          Get.defaultDialog(
              barrierDismissible: false,
              title: "نجاح",
              titleStyle: const TextStyle(
                  color: AppColor.primaryColor,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold),
              middleText: "تم ارسال الطلب لمناديب التوصيل.",
              middleTextStyle:
                  const TextStyle(color: AppColor.grey2, letterSpacing: 0),
              buttonColor: AppColor.primaryColor,
              textConfirm: "تم",
              confirmTextColor: Colors.white,
              onConfirm: () {
                  Get.offAllNamed(AppRoute.homepage);
              }
          );
        } else {
          Get.defaultDialog(
              title: "ُخطأ",
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
    } else { Get.snackbar("تنبيه", "تأكد من صحة البيانات"); }
  }


  addOrderRousheta() async {
    if(rousheta == null) Get.snackbar("تنبيه", "يجب إرفاق صورة الروشتة");
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await ordersData.addPharmOrderRousheta(myServices.sharedPreferences.getString("id").toString(), notes.text, lat, long, address, myServices.sharedPreferences.getString("city").toString(), rousheta!);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          
          try {
            await PushNotificationService().sendNotificationTopic("delivery", "طلب دواء جديد", "تم اضافة طلب دواء جديد", "none", "refreshpharmsorders").timeout(const Duration(seconds: 60));
          } on TimeoutException {
            print('Timeout');
          } catch (e) {
            print('Error: $e');
          }
          Get.defaultDialog(
              barrierDismissible: false,
              title: "نجاح",
              titleStyle: const TextStyle(
                  color: AppColor.primaryColor,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold),
              middleText: "تم ارسال الطلب لمناديب التوصيل.",
              middleTextStyle:
                  const TextStyle(color: AppColor.grey2, letterSpacing: 0),
              buttonColor: AppColor.primaryColor,
              textConfirm: "تم",
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.offAllNamed(AppRoute.homepage);
              }
          );
        } else {
          Get.defaultDialog(
              title: "ُخطأ",
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
    } else { Get.snackbar("تنبيه", "تأكد من صحة البيانات"); }
  }



  @override
  void onInit() {
    notes = TextEditingController();
    medstext = TextEditingController();
    lat = Get.arguments['lat'].toString();
    long = Get.arguments['long'].toString();
    address = Get.arguments['address'].toString();

    update();
    super.onInit();
  }
}
