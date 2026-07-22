import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/sellers_data.dart';
import 'package:almithaq/data/model/sellersmodel.dart';
import 'package:get/get.dart';

class RestaurantsController extends GetxController {

  SellersData sellersData = SellersData(Get.find());

  List<SellersModel> data = [];

  late StatusRequest statusRequest;

  bool hasMore = true;
  bool isLoadingMore = false;
  int currentOffset = 0;

  MyServices myServices = Get.find();

  getRestaurants() async {
    data.clear();
    currentOffset = 0;
    hasMore = true;
    statusRequest = StatusRequest.loading;
    update();
    var response = await sellersData.getRestaurants(offset: 0);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        data.addAll(listdata.map((e) => SellersModel.fromJson(e)));
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
    var response = await sellersData.getRestaurants(offset: currentOffset);
    if (response is Map) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        data.addAll(listdata.map((e) => SellersModel.fromJson(e)));
        hasMore = response['has_more'] == true;
        currentOffset = data.length;
      } else {
        hasMore = false;
      }
    }
    isLoadingMore = false;
    update();
  }

  refreshRestaurants() {
    getRestaurants();
  }

  @override
  void onInit() {
    getRestaurants();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
