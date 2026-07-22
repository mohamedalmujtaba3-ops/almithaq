import 'dart:async';
import 'package:almithaq/controller/wallet/wallet_controller.dart';
import 'package:almithaq/core/class/push_notification_service.dart';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/calculatedistance.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/functions/sortedsellercoord.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/checkout_date.dart';
import 'package:almithaq/view/screen/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  
  CheckoutData checkoutData = Get.put(CheckoutData(Get.find()));

  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  int delvprice = 0;

  late TextEditingController address;
  late List sellersCoord;
  late double userLat;
  late double userLong;


  checkout(String ordersprice, String lat, String long, String delvprice) async {

    WalletController? walletCtrl;
    try {
      walletCtrl = Get.find<WalletController>();
    } catch (_) {}

    if (walletCtrl != null) {
      double newTotal = double.parse(ordersprice) + double.parse(delvprice);
      if (!walletCtrl.canAfford(newTotal)) {
        Get.defaultDialog(
          title: "رصيد غير كافٍ",
          titleStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          middleText: "رصيدك في المحفظة لا يكفي لإضافة هذا المنتج.\nيرجى تغذية محفظتك أولاً.",
          textConfirm: "تغذية المحفظة",
          buttonColor: AppColor.primaryColor,
          confirmTextColor: Colors.white,
          textCancel: "إلغاء",
          cancelTextColor: AppColor.primaryColor,
          onConfirm: () {
            Get.back();
            Get.to(() => const WalletScreen());
          },
        );
        return;
      }
    }
    
    statusRequest = StatusRequest.loading;
    update();
    Map data = {
      "id": myServices.sharedPreferences.getString("id"),
      "pricedelivery": delvprice,
      "ordersprice": ordersprice,
      "ordersaddress": address.text,
      "lat": lat,
      "long": long,
      "city": myServices.sharedPreferences.getString("city"),
    };
    var response = await checkoutData.checkout(data);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.dialog(CircularProgressIndicator(color: AppColor.primaryColor,), barrierDismissible: false);
        for (int i = 0; i < sellersCoord.length; i++) {
            try { 
              await PushNotificationService().sendNotificationTopic("restaurants${sellersCoord[i]['seller_id']}", "طلب جديد", "أضاف ${myServices.sharedPreferences.getString('username')!.substring(0, 6)} طلباً جديداً", "none", "refreshorderspending").timeout(const Duration(seconds: 60));
              await PushNotificationService().sendNotificationTopic("supermarkets${sellersCoord[i]['seller_id']}", "طلب جديد", "أضاف ${myServices.sharedPreferences.getString('username')!.substring(0, 6)} طلباً جديداً", "none", "refreshorderspending").timeout(const Duration(seconds: 60));
            } on TimeoutException {
                print('Timeout');
            }  catch (e) {
                print('Error: $e');
            }
          }
          Get.back();
        Get.defaultDialog(
            title: "تم بنجاح",
            titleStyle: const TextStyle(
                color: AppColor.primaryColor, fontWeight: FontWeight.bold),
            middleText:
                "تم إرسال الطلب بنجاح، سيتم إخطارك عند انتهاء التحضير وتحرك عامل التوصيل.",
            buttonColor: AppColor.primaryColor,
            textConfirm: "تم",
            confirmTextColor: Colors.white,
            barrierDismissible: false,
            onConfirm: () {
              Get.offAllNamed(AppRoute.homepage);
            });

      } else {
        statusRequest = StatusRequest.none;
        Get.defaultDialog(
            title: "تم بنجاح",
            titleStyle: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold),
            middleText:
                "حدث خطأ، الرجاء المحاولة لاحقاً.",
            buttonColor: Colors.red,
            textConfirm: "تم",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.offAllNamed(AppRoute.homepage);
            });
      }

    }

    update();
  }





  deliveryPrice() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await checkoutData.deliveryPriceData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {

        int kmprice = int.parse(response['data'][0]['pref_value'].toString());
        List sortedSellersCoords = sortSellersByRoute(sellersCoord, userLat, userLong);
        print("oooooooooo $sortedSellersCoords");
        double totalDistance = 0;
          for (int i = 0; i < sellersCoord.length - 1; i++) {
            totalDistance += calculateDistance(
              sortedSellersCoords[i]['seller_lat'].toDouble(),
              sortedSellersCoords[i]['seller_long'].toDouble(),
              sortedSellersCoords[i + 1]['seller_lat'].toDouble(),
              sortedSellersCoords[i + 1]['seller_long'].toDouble(),
            );
          }
          totalDistance += calculateDistance(
            sortedSellersCoords.last['seller_lat'].toDouble(),
            sortedSellersCoords.last['seller_long'].toDouble(),
            userLat,
            userLong,
          );

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
    deliveryPrice();
    address = TextEditingController();
    sellersCoord = Get.arguments['sellersCoord'];
    userLat = Get.arguments['lat'];
    userLong = Get.arguments['long'];
    super.onInit();
  }

  @override
  void dispose() {
    address.dispose();
    super.dispose();
  }

}
