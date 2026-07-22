import 'dart:async';
import 'dart:io';
import 'package:almithaq/core/class/push_notification_service.dart';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/functions/uploadfile.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/wallet/wallet_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  WalletData walletData = WalletData(Get.find());
  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  double balance = 0.0;
  String bankAccount = "";
  String bankAccountClipboard = "";
  String fawryAccount = "";
  String fawryAccountClipboard = "";
  String ocashAccount = "";
  String ocashAccountClipboard = "";
  File? screenshotFile;

  // Transfer
  late TextEditingController receiverIdController;
  late TextEditingController transferAmountController;
  GlobalKey<FormState> transferFormKey = GlobalKey<FormState>();


  String get userId => myServices.sharedPreferences.getString("id") ?? "";

  loadWallet() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await walletData.getBalance(userId);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        balance = double.tryParse(response['balance'].toString()) ?? 0.0;
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    await loadPrefs();
    update();
  }




  loadPrefs() async {
    var response = await walletData.getPrefs();
    if (response is Map && response['status'] == "success") {
      List prefsList = response['data'];
      // bank khartoum account is typically pref_id=4 (mbok) - adjust if needed
      for (var pref in prefsList) {
        if (pref['pref_id'].toString() == "4") {
          bankAccount = "${pref['pref_value']} \n ${pref['pref_value_two']}";
          bankAccountClipboard = "${pref['pref_value_two']}";
        }
        if (pref['pref_id'].toString() == "5") {
          fawryAccount = "${pref['pref_value']} \n ${pref['pref_value_two']}";
          fawryAccountClipboard = "${pref['pref_value_two']}";
        }
        if (pref['pref_id'].toString() == "6") {
          ocashAccount = "${pref['pref_value']} \n ${pref['pref_value_two']}";
          ocashAccountClipboard = "${pref['pref_value_two']}";
        }
      }
    }
    update();
  }




  pickScreenshot() async {
    File? file = await imageUploadGallery();
    if (file != null) {
      screenshotFile = file;
      update();
    }
  }

  sendTopupRequest() async {
    if (screenshotFile == null) {
      Get.snackbar("تنبيه", "يرجى رفع صورة إثبات التحويل");
      return;
    }
    statusRequest = StatusRequest.loading;
    update();
    var response = await walletData.sendTopupRequest(userId, screenshotFile!);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        try {
          await PushNotificationService().sendNotificationTopic("admins", "طلب تغذية", "اضاف العميل ${myServices.sharedPreferences.getString("username")!.substring(0, 6)} طلب تغذية ", "none", "refreshwallet").timeout(const Duration(seconds: 60));
        } on TimeoutException {
          print('Timeout');
        } catch (e) {
          print('Error: $e');
        }
        screenshotFile = null;
        Get.defaultDialog(
          barrierDismissible: false,
          title: "تم الإرسال",
          titleStyle: const TextStyle(color: Color(0xfff0500d), fontWeight: FontWeight.bold),
          middleText: "طلبك قيد المراجعة، سيتم إضافة الرصيد بعد التحقق.",
          textConfirm: "حسناً",
          buttonColor: const Color(0xfff0500d),
          confirmTextColor: Colors.white,
          onConfirm: () => Get.back(),
        );
      } else {
        Get.snackbar("خطأ", "فشل في إرسال الطلب، حاول مرة أخرى");
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  transferBalance() async {
    if (!transferFormKey.currentState!.validate()) return;
    statusRequest = StatusRequest.loading;
    update();
    var response = await walletData.transferBalance(
      userId,
      receiverIdController.text.trim(),
      transferAmountController.text.trim(),
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        double amount = double.tryParse(transferAmountController.text.trim()) ?? 0;
        balance -= amount;
        receiverIdController.clear();
        transferAmountController.clear();
        Get.back();
        Get.snackbar("تم", "تم التحويل بنجاح");
      } else if (response['status'] == "failure") {
        String msg = response['message'] ?? "";
        if (msg == "INSUFFICIENT_BALANCE") {
          Get.snackbar("رصيد غير كافٍ", "رصيدك لا يكفي لإتمام هذه العملية");
        } else if (msg == "RECEIVER_NOT_FOUND") {
          Get.snackbar("خطأ", "المستخدم المحدد غير موجود");
        } else {
          Get.snackbar("خطأ", "فشل في التحويل");
        }
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  /// Called from cart to check if user can afford
  bool canAfford(double amount) {
    return balance >= amount;
  }

  @override
  void onInit() {
    receiverIdController = TextEditingController();
    transferAmountController = TextEditingController();
    Future.delayed(Duration(seconds: 1), ()=> loadWallet());
    super.onInit();
  }

  @override
  void dispose() {
    receiverIdController.dispose();
    transferAmountController.dispose();
    super.dispose();
  }

}
