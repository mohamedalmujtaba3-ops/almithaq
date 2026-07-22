import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/orders/pending_data.dart';
import 'package:almithaq/data/model/ordersmodel.dart';
import 'package:get/get.dart';

class OrdersPendingController extends GetxController {
  
  OrdersPendingData ordersPendingData = OrdersPendingData(Get.find());

  List<OrdersModel> data = [];

  late StatusRequest statusRequest;

  bool hasMore = true;
  bool isLoadingMore = false;
  int currentOffset = 0;

  MyServices myServices = Get.find();


  String printOrderStatus(String val) {
    if (val == "0") return "بانتظار موافقة البائع";
    else if (val == "1") return "بانتظار أخذه بواسطة التوصيل";
    else if (val == "2") return "بانتظار تحرك عامل التوصيل";
    else if (val == "3") return "بانتظار وصول عامل التوصيل";
    else if (val == "4") return "بانتظار تأكيد الإستلام";
    else if (val == "5") return "منتهي";
    else return "غير ناجح";
  }


  getOrders() async {
    data.clear();
    currentOffset = 0;
    hasMore = true;
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersPendingData
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
    var response = await ordersPendingData
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

  deleteOrder(String orderid) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersPendingData.deleteData(orderid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back();
        refrehOrder();
      } else {
        Get.back();
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }


  refrehOrder() {
    getOrders();
  }


  @override
  void onInit() {
    getOrders();
    super.onInit();
  }


}
