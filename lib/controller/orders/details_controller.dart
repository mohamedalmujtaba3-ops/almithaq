import 'dart:async';
import 'package:almithaq/core/class/push_notification_service.dart';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/orders/details_data.dart';
import 'package:almithaq/data/model/cartmodel.dart';
import 'package:almithaq/data/model/ordersmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class OrdersDetailsController extends GetxController {
  OrdersDetailsData ordersDetailsData = OrdersDetailsData(Get.find());

  List<CartModel> data = [];

  MyServices myServices = Get.find();

  late StatusRequest statusRequest;

  late OrdersModel ordersModel;

  Completer<GoogleMapController>? completercontroller;

  List<Marker> markers = [];

  double? lat;
  double? long;

  @override
  void onInit() {
    ordersModel = Get.arguments['ordersmodel'];
    getData();
    super.onInit();
  }



  String printOrderStatus(String val) {
    if (val == "0") { //pending
        return "بانتظار موافقة البائع";
    } else if (val == "1") { //approved
        return "بانتظار أخذه بواسطة التوصيل";
    } else if (val == "2") { //delivery approved
        return "بانتظار تحرك عامل التوصيل";
    } else if (val == "3") { //delivery moving
        return "بانتظار وصول عامل التوصيل";
    } else if (val == "4") { //delivery arrived
        return "بانتظار تأكيد الإستلام";
    } else if (val == "5") { //done
        return "منتهي";
    } else {
      return "غير ناجح";
    }
  }



  getData() async {

    data.clear();

    statusRequest = StatusRequest.loading;

    update();
    var department = ordersModel.orderNotes == "no" ? "restsup" : "pharms";
    var response = await ordersDetailsData.getData(ordersModel.orderId!, department);

    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success"){
        List listdata = response['data'];
        data.addAll(listdata.map((e) => CartModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }



  doneOrder(String rating) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersDetailsData.setDone(
        ordersModel.orderId!, ordersModel.orderDelId!, rating);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.dialog(CircularProgressIndicator(color: AppColor.primaryColor,), barrierDismissible: false);
        try {
          await PushNotificationService().sendNotificationTopic("delivery${ordersModel.orderDelId}", "تم تسليم الطلب بنجاح", "تم تسليم الطلب ${ordersModel.orderId} للعميل ${myServices.sharedPreferences.getString("username")!.substring(0, 6)} بنجاح", "none", "refreshordersarchive").timeout(const Duration(seconds: 60));
        } on TimeoutException {
          print('Timeout');
        } catch (e) {
          print('Error: $e');
        }
        Get.back();
        Get.defaultDialog(
          title: "تم بنجاح",
          titleStyle: const TextStyle(
              color: AppColor.primaryColor,
              letterSpacing: 0,
              fontWeight: FontWeight.bold),
          middleText: "إكتمل الطلب، شكراً لاستخدامك تطبيقنا",
          middleTextStyle:
              const TextStyle(color: AppColor.grey2, letterSpacing: 0),
          buttonColor: AppColor.primaryColor,
          textConfirm: "تم",
          confirmTextColor: Colors.white,
          barrierDismissible: false,
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
  }


  
}
