import 'package:almithaq/controller/orders/archive_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/data/model/ordersmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class CardOrdersListArchive extends GetView<OrdersArchiveController> {
  final OrdersModel listdata;
  const CardOrdersListArchive({Key? key, required this.listdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color.fromARGB(255, 255, 250, 247),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.toNamed(AppRoute.ordersdetails,
              arguments: {"ordersmodel": listdata});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_outline,
                    color: Colors.green, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "طلب رقم #${listdata.orderId}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.grey2,
                          fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    if (listdata.orderDestLat == "0")
                      Text(
                        "التوصيل: ${listdata.orderPricedelivery == "0" ? "مع المندوب" : listdata.orderPricedelivery} ",
                        style: const TextStyle(color: AppColor.grey, fontSize: 12),
                      )
                    else
                      Text(
                        "الإجمالي: ${listdata.orderTotalprice.toString() == "0" ? "مع المندوب" : "${listdata.orderTotalprice} "}",
                        style: const TextStyle(color: AppColor.grey, fontSize: 12),
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Jiffy.parse(listdata.orderDatetime!).toUtc().add(hours: -2).fromNow(),
                    style: const TextStyle(
                        color: AppColor.primaryColor, fontSize: 11),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text("مكتمل",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
