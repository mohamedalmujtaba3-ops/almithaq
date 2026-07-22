import 'package:almithaq/bindings/intialbindings.dart';
import 'package:almithaq/core/constant/apptheme.dart';
import 'package:almithaq/core/localization/translation.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/localization/changelocal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'الميثاق',
      locale: controller.language,
      theme: themeArabic,
      initialBinding: InitialBindings(),
      // routes: routes,
      getPages: routes,
    );
  }
}