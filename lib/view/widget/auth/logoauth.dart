import 'package:almithaq/core/constant/imgaeasset.dart'; 
import 'package:flutter/material.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(0), // Border radius
            child: Image.asset(
              width: 70,
              height: 70,
              AppImageAsset.logo,
            ),
        );
  }
}
