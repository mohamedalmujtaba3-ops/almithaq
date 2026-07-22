import 'package:almithaq/controller/orders/pending_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/data/model/ordersmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class CardOrdersList extends GetView<OrdersPendingController> {
  final OrdersModel listdata;
  const CardOrdersList({Key? key, required this.listdata}) : super(key: key);

  Color _statusColor(String? status) {
    switch (status) {
      case '0': return Colors.orange;
      case '1': return Colors.blue;
      case '2': return Colors.indigo;
      case '3': return Colors.teal;
      case '4': return Colors.green;
      default:  return Colors.grey;
    }
  }

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
              // Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.thirdColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shopping_bag_outlined,
                    color: AppColor.primaryColor, size: 22),
              ),
              const SizedBox(width: 12),
              // Info
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
                        "التوصيل: ${listdata.orderPricedelivery == "0" ? "مع المندوب" : "${listdata.orderPricedelivery} "}",
                        style:
                            const TextStyle(color: AppColor.grey, fontSize: 12),
                      )
                    else
                      Text(
                        "الإجمالي: ${listdata.orderTotalprice.toString() == "0" ? "مع المندوب" : "${listdata.orderTotalprice} "}",
                        style:
                            const TextStyle(color: AppColor.grey, fontSize: 12),
                      ),
                  ],
                ),
              ),
              // Right side
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _statusColor(listdata.orderStatus).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      controller.printOrderStatus(listdata.orderStatus!),
                      style: TextStyle(
                          color: _statusColor(listdata.orderStatus),
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (listdata.orderStatus == "0") ...[
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          title: "متأكد ؟",
                          titleStyle: const TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold),
                          middleText: "هل تريد حذف الطلب ؟",
                          buttonColor: AppColor.primaryColor,
                          cancelTextColor: AppColor.primaryColor,
                          textConfirm: "نعم",
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            controller.deleteOrder(listdata.orderId!);
                          },
                          textCancel: "لا",
                          onCancel: () {
                            Get.back();
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text("حذف",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
