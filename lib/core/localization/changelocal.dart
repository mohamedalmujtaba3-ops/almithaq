import 'dart:async';

import 'package:almithaq/core/constant/apptheme.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/functions/fcmconfig.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController with WidgetsBindingObserver {
  Locale? language;

  MyServices myServices = Get.find();

  ThemeData appTheme = themeArabic;

  StreamSubscription<ServiceStatus>? _serviceStatusSub;
  bool _locationDialogOpen = false;

  changeLang() {
    Locale locale = Locale("ar");
    myServices.sharedPreferences.setString("lang", "ar");
    appTheme =  themeArabic;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  requestPerLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Get.snackbar("تنبيه", "الرجاء اعطاء صلاحية الموقع للتطبيق");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Get.snackbar("تنبيه", "لا يمكن استعمال التطبيق من دون اللوكيشين");
    }

    // الصلاحية موجودة، الآن نتأكد من أن خدمة الموقع (GPS) نفسها مُشغّلة فعليًا.
    await checkLocationServiceEnabled();
  }

  /// يتحقق من تشغيل خدمة الموقع (GPS)، وإن كانت متوقفة يعرض
  /// نافذة إلحاح لا يمكن تجاهلها إلا بتشغيل الخدمة.
  Future<void> checkLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceDialog();
    } else {
      _closeLocationServiceDialogIfOpen();
    }
  }

  void _showLocationServiceDialog() {
    if (_locationDialogOpen) return;
    _locationDialogOpen = true;
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text("خدمة الموقع غير مفعّلة"),
          content: const Text(
              "لا يمكن استخدام التطبيق بشكل صحيح دون تفعيل خدمة تحديد الموقع (GPS). الرجاء تشغيلها للمتابعة."),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                await Geolocator.openLocationSettings();
              },
              child: const Text("تشغيل خدمة الموقع"),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _closeLocationServiceDialogIfOpen() {
    if (_locationDialogOpen) {
      _locationDialogOpen = false;
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // إعادة التحقق كل مرة يعود فيها التطبيق للواجهة (مثلاً بعد فتح الإعدادات
    // أو بعد أن كان التطبيق في الخلفية وخدمة الموقع أُغلقت أثناء ذلك).
    if (state == AppLifecycleState.resumed) {
      checkLocationServiceEnabled();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onInit() { 
    requestPermissionNotification() ; 
    fcmconfig();
    requestPerLocation();
    language = const Locale("ar");
    appTheme = themeArabic;

    WidgetsBinding.instance.addObserver(this);
    // يراقب تغيّر حالة خدمة الموقع لحظيًا أثناء تشغيل التطبيق (وليس فقط عند فتحه).
    _serviceStatusSub = Geolocator.getServiceStatusStream().listen((status) {
      if (status == ServiceStatus.disabled) {
        _showLocationServiceDialog();
      } else {
        _closeLocationServiceDialogIfOpen();
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _serviceStatusSub?.cancel();
    super.onClose();
  }
}
