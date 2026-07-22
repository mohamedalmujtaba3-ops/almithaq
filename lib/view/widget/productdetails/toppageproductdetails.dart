import 'package:almithaq/core/constant/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:almithaq/controller/productdetails_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopProductPageDetails extends GetView<ProductDetailsControllerImp> {
  const TopProductPageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 120,
          decoration: const BoxDecoration(color: AppColor.primaryColor),
        ),
        Positioned(
            top: 30.0,
            right: Get.width / 8,
            left: Get.width / 8,
            child: Hero(
              tag: "${controller.itemsModel.itemsId}",
              child: InkWell(
                onTap: () {
                Get.toNamed(AppRoute.viewimage, arguments: {"imageurl" : "${AppLink.imagestItems}/${controller.itemsModel.itemsImage!}"});
              },
                child: CachedNetworkImage(
                  imageUrl:
                      "${AppLink.imagestItems}/${controller.itemsModel.itemsImage!}",
                  height: 150,
                ),
              ),
            ))
      ],
    );
  }
}
