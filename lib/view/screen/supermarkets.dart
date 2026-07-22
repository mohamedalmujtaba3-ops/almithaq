import 'package:almithaq/controller/supermarkets_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/view/widget/cardlistsupermarkets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Supermarkets extends StatelessWidget {
  const Supermarkets({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String search = "";
    Get.put(SupermarketsController());
    SupermarketsController thecontroller = Get.find();
    String city = thecontroller.myServices.sharedPreferences.getString("city")!;
    return Scaffold(
        appBar: AppBar(
          title: Text("المتاجر", style: TextStyle(fontSize: 14, color: Colors.white),),
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: AppColor.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: 150,
              child: TextField(
                cursorHeight: 20,
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 13, color: Colors.white),
                onChanged: (val) {
                  search = val;
                  thecontroller.update();
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 12),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(223, 255, 255, 255))),
                  suffixIconColor: Colors.white,
                  hintStyle: TextStyle(fontSize: 13, color: Color.fromARGB(215, 255, 255, 255)),
                  hintText: " البحث بالاسم",
                  suffixIcon: Icon(Icons.search)
                ),
              ),
            )
          ],
        ),
        body: Container(
          height: Get.height,
          padding: const EdgeInsets.all(10),
          child: GetBuilder<SupermarketsController>(
              builder: ((controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: ListView.builder(
                    itemCount: controller.data.length + 1,
                    itemBuilder: ((context, index) {
                      if (index < controller.data.length) {
                        return CardSupermarketsList(search, city, listdata: controller.data[index]);
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
                            style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
                            onPressed: () => controller.loadMore(),
                            child: const Text("عرض المزيد", style: TextStyle(color: Colors.white)),
                          ),
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(child: Text("لا توجد نتائج أخرى", style: TextStyle(color: Colors.grey))),
                      );
                    }),
                  )))),
        ));
  }
}
