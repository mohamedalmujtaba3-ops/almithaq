import 'package:almithaq/controller/items_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/data/model/itemsmodel.dart';
import 'package:almithaq/view/screen/home.dart';
import 'package:almithaq/view/widget/items/customlistitems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemsControllerImp controller = Get.put(ItemsControllerImp());
    String search = "";

    return Scaffold(
      appBar: AppBar(
          title: Text(controller.sellerDetails!.sellerName.toString(),
          style: TextStyle(fontSize: 14, color: Colors.white), ),
          centerTitle: false,
          titleSpacing: 1,
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
                  controller.update();
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 12),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(223, 255, 255, 255))),
                  suffixIconColor: Colors.white,
                  hintStyle: TextStyle(fontSize: 13, color: Color.fromARGB(215, 255, 255, 255)),
                  hintText: " البحث بالمنتج",
                  suffixIcon: Icon(Icons.search)
                ),
              ),
            )
          ],
        ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(children: [
          const SizedBox(height: 20),
          GetBuilder<ItemsControllerImp>(
              builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: !controller.isSearch
                      ? Column(
                          children: [
                            GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, childAspectRatio: 0.7),
                                itemBuilder: (BuildContext context, index) {
                                  return CustomListItems(
                                      itemsModel: ItemsModel.fromJson(
                                          controller.data[index]), search: search);
                                }),
                            if (controller.isLoadingMore)
                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Center(child: CircularProgressIndicator()),
                              )
                            else if (controller.hasMore)
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
                                  onPressed: () => controller.loadMore(),
                                  child: const Text("عرض المزيد", style: TextStyle(color: Colors.white)),
                                ),
                              )
                            else
                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Center(child: Text("لا توجد نتائج أخرى", style: TextStyle(color: Colors.grey))),
                              ),
                          ],
                        )
                      : ListItemsSearch(listdatamodel: controller.listdata)))
        ]),
      ),
    );
  }
}
