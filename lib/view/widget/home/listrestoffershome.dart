import 'package:almithaq/controller/home_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/data/model/itemsmodel.dart';
import 'package:almithaq/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListRestOffersHome extends GetView<HomeControllerImp> {
  const ListRestOffersHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
          itemCount: controller.restaurantsoffers.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return OffersHome(
                itemsModel: ItemsModel.fromJson(controller.restaurantsoffers[i]));
          }),
    );
  }
}

class OffersHome extends StatelessWidget {
  final ItemsModel itemsModel;
  const OffersHome({Key? key, required this.itemsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
            Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
          },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 252, 105, 52).withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            height: 120,
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "${AppLink.imagestItems}/${itemsModel.itemsImage}",
                height: 100,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              bottom: Get.height / 20,
              right: 10,
              child: Container(
                width: 200,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(142, 56, 39, 39),
                ),
                child: Column(
                  children: [
                    Text(
                      "${itemsModel.itemsName}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    Text(
                      "من ${itemsModel.sellerName}",
                      style: const TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    Text(
                        "${itemsModel.itemsDesc}",
                        style: const TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 10),
                      )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
