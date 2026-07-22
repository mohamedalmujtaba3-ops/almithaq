import 'package:almithaq/controller/orders/pending_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/view/widget/orders/orderslistcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersPending extends StatelessWidget {
  const OrdersPending({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(OrdersPendingController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('طلبات غير مكتملة',
            style: TextStyle(color: Colors.white, fontSize: 14)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<OrdersPendingController>(
          builder: ((controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: controller.data.isEmpty
                ? const Center(
                    child: Text("لا توجد طلبات",
                        style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: controller.data.length + 1,
                    itemBuilder: ((context, index) {
                      if (index < controller.data.length) {
                        return CardOrdersList(listdata: controller.data[index]);
                      }
                      if (controller.isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (controller.hasMore) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor),
                            onPressed: () => controller.loadMore(),
                            child: const Text("عرض المزيد",
                                style: TextStyle(color: Colors.white)),
                          ),
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(
                            child: Text("لا توجد نتائج أخرى",
                                style: TextStyle(color: Colors.grey))),
                      );
                    })),
          )),
        ),
      ),
    );
  }
}
