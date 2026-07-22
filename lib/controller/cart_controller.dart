
import 'package:almithaq/controller/wallet/wallet_controller.dart';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/cart_data.dart';
import 'package:almithaq/data/model/cartmodel.dart';
import 'package:almithaq/view/screen/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {

  CartData cartData = CartData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  List<CartModel> data = [];

  double priceorders = 0.0;

  List sellersCoord = [];

  int totalcountitems = 0;


  add(String itemsid, String sellerid, {double itemPrice = 0.0}) async {
    // Check wallet balance before adding
    WalletController? walletCtrl;
    try {
      walletCtrl = Get.find<WalletController>();
    } catch (_) {}

    if (walletCtrl != null) {
      double newTotal = priceorders + itemPrice;
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
    var response = await cartData.addCart(
        myServices.sharedPreferences.getString("id")!, itemsid, sellerid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("تم اضافة المنتج الى السلة "));
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }



  doneGoToAddress() {
    if (data.isEmpty) return Get.snackbar("تنبيه", "السلة فارغة");

    // Check wallet balance before checkout
    WalletController? walletCtrl;
    try {
      walletCtrl = Get.find<WalletController>();
    } catch (_) {}

    if (walletCtrl != null && !walletCtrl.canAfford(priceorders)) {
      Get.defaultDialog(
        title: "رصيد غير كافٍ",
        titleStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        middleText: "رصيدك في المحفظة (${walletCtrl.balance.toStringAsFixed(2)} جنيه) لا يكفي لإتمام الطلب.\nيرجى تغذية محفظتك.",
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

    view();
    Get.toNamed(AppRoute.picklocation, arguments: {
      "priceorder": priceorders.round().toString() , 
      "sellersCoord" : sellersCoord
    });
  }



  getTotalPrice() {
    return (priceorders);
  }



  delete(String itemsid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await cartData.deleteCart(
        myServices.sharedPreferences.getString("id")!, itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("تم ازالة المنتج من السلة "));
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }
  


  resetVarCart() {
    totalcountitems = 0;
    priceorders = 0.0;
    data.clear();
  }



  refreshPage() {
    resetVarCart();
    view();
  }



  view() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await cartData.viewCart(myServices.sharedPreferences.getString("id")!);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        if (response['datacart']['status'] == 'success') {
          List dataresponse = response['datacart']['data'];
          Map dataresponsecountprice = response['countprice'];
          sellersCoord = response['sellersCoord'];
          data.clear();
          data.addAll(dataresponse.map((e) => CartModel.fromJson(e)));
          totalcountitems = dataresponsecountprice['totalcount'];
          priceorders = (dataresponsecountprice['totalprice']).toDouble();
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }



  @override
  void onInit() {
    view();
    super.onInit();
  }


}
