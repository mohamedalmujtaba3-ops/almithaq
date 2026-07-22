import 'package:almithaq/controller/productdetails_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/view/widget/productdetails/priceandcount.dart';
import 'package:almithaq/view/widget/productdetails/toppageproductdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ProductDetailsControllerImp controller =
        Get.put(ProductDetailsControllerImp());
        
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.itemsModel.itemsName.toString(),
          style: TextStyle(fontSize: 14, color: Colors.white), ),
          centerTitle: false,
          titleSpacing: 1,
          backgroundColor: AppColor.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          
        ),
        bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 40,
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppColor.primaryColor,
                onPressed: () {
                  Get.toNamed(AppRoute.cart);
                },
                child: const Text(
                  "الذهاب إلى السلة",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))),
        body: GetBuilder<ProductDetailsControllerImp>(
            builder: (controller) => ListView(children: [
                  const TopProductPageDetails(),
                  const SizedBox(
                    height: 80,
                  ),
                  HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${controller.itemsModel.itemsName}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            color: AppColor.primaryColor,
                                            fontSize: 20
                                          )),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 221, 226, 250),
                                      borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Text("${controller.itemsModel.sellerName}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              color: AppColor.primaryColor,
                                              fontSize: 12
                                            )),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              PriceAndCountItems(
                                  onAdd: () {
                                    controller.add();
                                  },
                                  onRemove: () {
                                    controller.remove();
                                  },
                                  price:
                                      "${int.parse(controller.itemsModel.itemsPrice!) - int.parse(controller.itemsModel.itemsDiscount!)} ",
                                  count: "${controller.countitems}"),
                              const SizedBox(height: 10),
                              Text("${controller.itemsModel.itemsDesc}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: AppColor.grey2)),
                              const SizedBox(height: 10),
                              // Text("Color",
                              //     style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              //           color: AppColor.fourthColor,
                              //         )),
                              // const SizedBox(height: 10),
                              // const SubitemsList()
                            ]),
                      ))
                ])));
  }
}
