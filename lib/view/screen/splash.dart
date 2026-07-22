import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/imgaeasset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var res;

  @override
  void initState() {
    super.initState();
    // Simulate a time-consuming task (e.g., loading data) for the splash screen.
    // Replace this with your actual data loading logic.
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Get.offAllNamed('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 4.0),
              child: Image.asset(
                AppImageAsset.splashscreen,
                width: 220,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: Get.height / 4.5),
            const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("بواسطة", style: TextStyle(color: AppColor.grey2),),
                Text(
                  "شركة الميثاق المحدودة",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColor.primaryColor,
                      letterSpacing: 0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
