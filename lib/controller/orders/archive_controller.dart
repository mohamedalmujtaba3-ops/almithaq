import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/orders/archive_data.dart';
import 'package:almithaq/data/model/ordersmodel.dart';
import 'package:get/get.dart';

class OrdersArchiveController extends GetxController {
  OrdersArchiveData ordersArchiveData = OrdersArchiveData(Get.find());

  List<OrdersModel> data = [];

  late StatusRequest statusRequest;

  bool hasMore = true;
  bool isLoadingMore = false;
  int currentOffset = 0;

  MyServices myServices = Get.find();


  getOrders() async {
    data.clear();
    currentOffset = 0;
    hasMore = true;
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersArchiveData
        .getData(myServices.sharedPreferences.getString("id")!, offset: 0);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        data.addAll(listdata.map((e) => OrdersModel.fromJson(e)));
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
    var response = await ordersArchiveData
        .getData(myServices.sharedPreferences.getString("id")!, offset: currentOffset);
    if (response is Map) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        data.addAll(listdata.map((e) => OrdersModel.fromJson(e)));
        hasMore = response['has_more'] == true;
        currentOffset = data.length;
      } else {
        hasMore = false;
      }
    }
    isLoadingMore = false;
    update();
  }

  refrehOrder() {
    getOrders();
  }

  @override
  void onInit() {
    print("oooo ${myServices.sharedPreferences.getString("jwt_token")}");
    getOrders();
    super.onInit();
  }
}
