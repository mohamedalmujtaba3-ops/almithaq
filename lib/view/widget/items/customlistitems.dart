import 'package:cached_network_image/cached_network_image.dart';
import 'package:almithaq/controller/items_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/imgaeasset.dart';
import 'package:almithaq/data/model/itemsmodel.dart';
import 'package:almithaq/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListItems extends GetView<ItemsControllerImp> {
  final ItemsModel itemsModel;
  final String? search;
  const CustomListItems(
      {Key? key, required this.itemsModel, this.search})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool matches = search == "" ||
        itemsModel.itemsName.toString().contains(search!);

    if (!matches) return const SizedBox(height: 0.1);

    final bool hasDiscount = itemsModel.itemsDiscount != "0";
    final String displayPrice = hasDiscount
        ? "${(int.parse(itemsModel.itemsPrice!) - int.parse(itemsModel.itemsDiscount!))} ج"
        : "${itemsModel.itemsPrice} ج";

    return InkWell(
      onTap: () => controller.goToPageProductDetails(itemsModel),
      borderRadius: BorderRadius.circular(14),
      child: Card(
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image section
                Hero(
                  tag: "${itemsModel.itemsId}",
                  child: CachedNetworkImage(
                    imageUrl: AppLink.imagestItems +
                        "/" +
                        itemsModel.itemsImage!,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (c, u) => Container(
                      height: 110,
                      color: AppColor.thirdColor,
                      child: const Center(
                          child: CircularProgressIndicator(
                              color: AppColor.primaryColor, strokeWidth: 2)),
                    ),
                    errorWidget: (c, u, e) => Container(
                      height: 110,
                      color: AppColor.thirdColor,
                      child: const Icon(Icons.image_not_supported,
                          color: AppColor.grey),
                    ),
                  ),
                ),
                // Info section
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${itemsModel.itemsName}",
                        style: const TextStyle(
                            color: AppColor.grey2,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        displayPrice,
                        style: const TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      if (hasDiscount)
                        Text(
                          "${itemsModel.itemsPrice} ج",
                          style: const TextStyle(
                              color: AppColor.grey,
                              decorationStyle: TextDecorationStyle.solid,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColor.grey,
                              decorationThickness: 2,
                              fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            // Discount badge
            if (hasDiscount)
              Positioned(
                top: 6,
                left: 6,
                child: Image.asset(AppImageAsset.saleOne, width: 38),
              ),
          ],
        ),
      ),
    );
  }
}
