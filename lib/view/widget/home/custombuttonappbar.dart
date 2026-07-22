import 'package:almithaq/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CustomButtonAppBar extends StatelessWidget {
  final void Function()? onPressed;
  final String textbutton;
  final IconData icondata;
  final bool? active   ;
  const CustomButtonAppBar(
      {Key? key,
      required this.textbutton,
      required this.icondata,
      required this.onPressed,
      required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: Get.width / 3.5,
      onPressed: onPressed,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icondata,
            size: 30, color: active == true ? Colors.white : AppColor.thirdColor),
        // Text(textbutton,
        //     style: TextStyle(
        //         color: active == true ? AppColor.primaryColor : AppColor.grey2))
      ]),
    );
  }
}
