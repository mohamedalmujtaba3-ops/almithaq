import 'dart:async';
import 'package:almithaq/core/class/push_notification_service.dart';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/calculatedistance.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/checkout_date.dart';
import 'package:almithaq/data/model/sellersmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherOrdersFormController extends GetxController {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  CheckoutData ordersData = CheckoutData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  late SellersModel sellersModel;

  MyServices myServices = Get.find();

  int delvprice = 0;

  late TextEditingController desc;
  late TextEditingController address;
  late String startlat;
  late String startlong;
  late String destlat;
  late String destlong;

  addOrder() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await ordersData.addOtherOrder(myServices.sharedPreferences.getString("id").toString(), desc.text, startlat, startlong, destlat, destlong, address.text, delvprice.toString(), myServices.sharedPreferences.getString("city").toString());
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          try {
            await PushNotificationService().sendNotificationTopic("delivery", "طلب جديد", "طلب جديد بالتطبيق كن اول من يقبل", "none", "refreshotherorders").timeout(const Duration(seconds: 60));
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








  deliveryPriceTwo() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.deliveryPriceData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {

        int kmprice = int.parse(response['data'][0]['pref_value'].toString());
        double totalDistance = calculateDistance(double.parse(startlat), double.parse(startlong), double.parse(destlat), double.parse(destlong));
        delvprice = (totalDistance.ceil() * kmprice);

      } else {
        Get.snackbar("حدث خطأ ما", "عفواً حدث خطأ، أعد المحاولة") ;
      }
      // End
    }
    update();
  }




  @override
  void onInit() {
    desc = TextEditingController();
    address = TextEditingController();
    startlat = Get.arguments['start_lat'].toString();
    startlong = Get.arguments['start_long'].toString();
    destlat = Get.arguments['dest_lat'].toString();
    destlong = Get.arguments['dest_long'].toString();
    update();
    super.onInit();
    deliveryPriceTwo();
  }
}
