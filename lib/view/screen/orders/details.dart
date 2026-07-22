import 'package:almithaq/controller/orders/details_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    String delvRating = "0";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('تفاصيل الطلب',
            style: TextStyle(color: Colors.white, fontSize: 14)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: GetBuilder<OrdersDetailsController>(
        init: OrdersDetailsController(),
        builder: ((controller) => HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Order Info Card ──────────────────────────────────────
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      // Header row
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColor.thirdColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.receipt_long,
                                color: AppColor.primaryColor, size: 20),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "طلب رقم #${controller.ordersModel.orderId}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.grey2,
                                fontSize: 15),
                          ),
                          const Spacer(),
                          Text(Jiffy.parse(controller.ordersModel.orderDatetime!).toUtc().add(hours: -2)
                                .fromNow(),
                            style: const TextStyle(
                                color: AppColor.primaryColor, fontSize: 11),
                          ),
                        ],
                      ),
                      const Divider(height: 20),

                      // Order items row
                      _detailRow(
                        label: "عناصر الطلب",
                        trailing: GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              title: "عناصر الطلب",
                              titleStyle: const TextStyle(
                                  color: AppColor.primaryColor),
                              titlePadding:
                                  const EdgeInsets.only(top: 20),
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                              content:
                                  controller.ordersModel.orderNotes!
                                              .replaceAll("'", "") ==
                                          "no"
                                      ? Column(children: [
                                          Table(
                                            children: [
                                              const TableRow(children: [
                                                Text("المنتج",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("الكمية",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("السعر",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                              ...List.generate(
                                                  controller.data.length,
                                                  (index) => TableRow(
                                                          children: [
                                                            Text(
                                                                "${controller.data[index].itemsName}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                            Text(
                                                                "${controller.data[index].countitems}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                            Text(
                                                                "${controller.data[index].itemsprice}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ]))
                                            ],
                                          ),
                                        ])
                                      : controller.ordersModel.orderRousheta!
                                                  .replaceAll("'", "") !=
                                              "no"
                                          ? Column(children: [
                                              Image.network(
                                                  "${AppLink.server}/upload/rousheta/${controller.ordersModel.orderRousheta}"),
                                              const SizedBox(height: 5),
                                              Text(
                                                controller
                                                    .ordersModel.orderNotes!,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 88, 88, 88),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ])
                                          : controller
                                                      .ordersModel.orderMedstext!
                                                      .replaceAll("'", "") !=
                                                  "no"
                                              ? Column(children: [
                                                  Text(
                                                    controller.ordersModel
                                                        .orderMedstext!,
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 88, 88, 88),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const Divider(),
                                                  Text(
                                                    controller
                                                        .ordersModel.orderNotes!,
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 88, 88, 88),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ])
                                              : Text(
                                                  controller.ordersModel
                                                      .orderNotes!,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 88, 88, 88),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColor.thirdColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text("عرض",
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      const Divider(height: 1),

                      _infoRow(
                        "سعر التوصيل",
                        controller.ordersModel.orderPricedelivery == "0"
                            ? "مع المندوب"
                            : "${controller.ordersModel.orderPricedelivery} ج",
                      ),

                      if (controller.ordersModel.orderDestLat == "0") ...[
                        const Divider(height: 1),
                        _infoRow(
                          "إجمالي السعر",
                          controller.ordersModel.orderTotalprice == "0"
                              ? "مع المندوب"
                              : "${controller.ordersModel.orderTotalprice} ج",
                          highlight: true,
                        ),
                      ],

                      const Divider(height: 1),
                      _infoRow(
                        "حالة الطلب",
                        controller.printOrderStatus(
                            controller.ordersModel.orderStatus!),
                      ),

                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 4),
                        child: Row(
                          children: [
                            const Text("العنوان",
                                style: TextStyle(
                                    color: AppColor.grey, fontSize: 13)),
                            const Spacer(),
                            SizedBox(
                              width: 180,
                              child: Text(
                                "${controller.ordersModel.orderAddress}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    color: AppColor.grey2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // ── Actions Card ─────────────────────────────────────────
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 1.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 14),
                  child: Column(
                    children: [
                      if (controller.ordersModel.orderStatus == "4")
                        _actionButton(
                          label: "تأكيد الإستلام",
                          icon: Icons.done_all,
                          color: Colors.green,
                          onTap: () {
                            Get.defaultDialog(
                              title: "تأكيد الإستلام",
                              titleStyle: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              middleText: "هل إستلمت الطلب ؟",
                              buttonColor: Colors.green,
                              cancelTextColor: Colors.green,
                              textConfirm: "نعم",
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                Get.dialog(
                                  barrierColor: const Color.fromARGB(
                                      188, 255, 255, 255),
                                  barrierDismissible: false,
                                  Container(
                                    color: const Color.fromARGB(
                                        177, 255, 255, 255),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "تقييم المندوب للمتابعة",
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.none,
                                            fontSize: 25,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        RatingBar.builder(
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(Icons.star,
                                                  color: Colors.amber),
                                          onRatingUpdate: (rating) {
                                            delvRating =
                                                rating.ceil().toString();
                                            controller
                                                .doneOrder(delvRating);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              textCancel: "لا",
                              onCancel: () {
                                Get.back();
                              },
                            );
                          },
                        ),

                      if (controller.ordersModel.orderStatus == "2" ||
                          controller.ordersModel.orderStatus == "3" ||
                          controller.ordersModel.orderStatus == "4") ...[
                        const SizedBox(height: 8),
                        _actionButton(
                          label: "معلومات المندوب",
                          icon: Icons.person_outline,
                          color: AppColor.primaryColor,
                          onTap: () {
                            Get.defaultDialog(
                              titlePadding: const EdgeInsets.all(15),
                              title: "معلومات المندوب",
                              content: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  children: [
                                    const Text(
                                        "التعامل خارج التطبيق يفقدك حقك عند حدوث خطأ ما، وأيضاً يفقدك ميزة ان التطبيق يحسب السعر بالكيلومتر ليقدم لك سعرا عادلاً"),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(Icons.person),
                                        const SizedBox(width: 15),
                                        Text(
                                          controller.data[0].delName
                                              .toString(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 88, 88, 88),
                                              fontSize: 12,
                                              fontWeight:
                                                  FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    Row(
                                      children: [
                                        const Icon(Icons.phone),
                                        const SizedBox(width: 15),
                                        Text(
                                          controller.data[0].delPhone
                                              .toString(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 88, 88, 88),
                                              fontSize: 12,
                                              fontWeight:
                                                  FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],

                      if (controller.ordersModel.orderDestLat != "0") ...[
                        const SizedBox(height: 8),
                        _actionButton(
                          label: "وجهة الطلب",
                          icon: Icons.flag_outlined,
                          color: AppColor.primaryColor,
                          onTap: () {
                            Get.toNamed(AppRoute.startinglocation,
                                arguments: {
                                  "lat": controller
                                      .ordersModel.orderDestLat
                                      .toString(),
                                  "long": controller
                                      .ordersModel.orderDestLong
                                      .toString()
                                });
                          },
                        ),
                      ],

                      const SizedBox(height: 8),
                      _actionButton(
                        label: "عنوان الطلب",
                        icon: Icons.location_on_outlined,
                        color: AppColor.primaryColor,
                        onTap: () {
                          Get.toNamed(AppRoute.startinglocation,
                              arguments: {
                                "lat": controller.ordersModel.orderLat
                                    .toString(),
                                "long": controller.ordersModel.orderLong
                                    .toString()
                              });
                        },
                      ),

                      const SizedBox(height: 8),
                      if(controller.ordersModel.orderStatus != "5")
                      _actionButton(
                        label: "تتبع الطلب",
                        icon: Icons.delivery_dining,
                        color: AppColor.primaryColor,
                        onTap: () {
                          if (controller.ordersModel.orderDelLat == "0" ||
                              controller.ordersModel.orderDelLat ==
                                  "0.0" ||
                              controller.ordersModel.orderDelLat == null) {
                            Get.snackbar("عفواً",
                                "عامل التوصيل لم يتحرك، الطلب لم يجهز بعد");
                          } else {
                            Get.toNamed(AppRoute.livelocation,
                                arguments: {
                                  "orderid":
                                      controller.ordersModel.orderId,
                                  "user_lat": double.parse(
                                      controller.ordersModel.orderLat!),
                                  "user_long": double.parse(
                                      controller.ordersModel.orderLong!),
                                  "del_lat": double.parse(controller
                                      .ordersModel.orderDelLat!),
                                  "del_long": double.parse(controller
                                      .ordersModel.orderDelLong!),
                                });
                          }
                        },
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        )),
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(color: AppColor.grey, fontSize: 13)),
          const Spacer(),
          Text(value,
              style: TextStyle(
                  color: highlight ? AppColor.primaryColor : AppColor.grey2,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
        ],
      ),
    );
  }

  Widget _detailRow({required String label, required Widget trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(color: AppColor.grey, fontSize: 13)),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: color, size: 18),
        label: Text(label, style: TextStyle(color: color, fontSize: 14)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color.withOpacity(0.4)),
          padding: const EdgeInsets.symmetric(vertical: 11),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
