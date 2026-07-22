// ignore_for_file: prefer_const_constructors

import 'package:almithaq/controller/cart_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/view/widget/cart/buttoncart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavgationBarCart extends GetView<CartController> {
  final String price;
  final String totalprice;
  const BottomNavgationBarCart(
      { Key? key,
      required this.price,
      required this.totalprice })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("السعر", style: TextStyle(fontSize: 16))),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("$price ج", style: TextStyle(fontSize: 16)))
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("مجموع السعر",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor))),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("$totalprice ج",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor)))
              ],
            ),
          ]),
        ),
        CustomButtomCart(
          text: "طلب",
          onPressed: () { 
            controller.doneGoToAddress() ; 
          },
        ),
        const SizedBox(height: 10,)
      ],
    ));
  }
}
