import 'package:almithaq/controller/home_controller.dart';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/items_data.dart';
import 'package:almithaq/data/model/sellersmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ItemsControllerImp extends SearchMixController {
  SellersModel? sellerDetails;

  ItemsData itemsData = ItemsData(Get.find());

  List data = [];

  late StatusRequest statusRequest;

  bool hasMore = true;
  bool isLoadingMore = false;
  int currentOffset = 0;

  MyServices myServices = Get.find();

  @override
  void onInit() {
    search = TextEditingController();
    sellerDetails = Get.arguments['sellermodel'];
    getItems(sellerDetails!.sellerId);
    super.onInit();
  }

  getItems(sellerid) async {
    data.clear();
    currentOffset = 0;
    hasMore = true;
    statusRequest = StatusRequest.loading;
    var response = await itemsData.getData(sellerid.toString(), offset: 0);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        data.addAll(response['data']);
        hasMore = response['has_more'] == true;
        currentOffset = data.length;
      } else {
        statusRequest = StatusRequest.failure;
        hasMore = false;
      }
    }
    update();
  }

  loadMore() async {
    if (!hasMore || isLoadingMore) return;
    isLoadingMore = true;
    update();
    var response = await itemsData.getData(
        sellerDetails!.sellerId.toString(), offset: currentOffset);
    if (response is Map) {
      if (response['status'] == "success") {
        data.addAll(response['data']);
        hasMore = response['has_more'] == true;
        currentOffset = data.length;
      } else {
        hasMore = false;
      }
    }
    isLoadingMore = false;
    update();
  }

  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }
}
