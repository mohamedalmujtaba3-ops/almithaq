import 'package:almithaq/controller/orders/rejected_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/view/widget/orders/orderslistcardrejected.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersRejectedView extends StatelessWidget {
  const OrdersRejectedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(OrdersRejectedController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('طلبات غير ناجحة',
            style: TextStyle(color: Colors.white, fontSize: 14)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<OrdersRejectedController>(
          builder: ((controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: controller.data.isEmpty
                ? const Center(
                    child: Text("لا توجد طلبات",
                        style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: ((context, index) =>
                        CardOrdersListRejected(
                            listdata: controller.data[index])),
                  ),
          )),
        ),
      ),
    );
  }
}
