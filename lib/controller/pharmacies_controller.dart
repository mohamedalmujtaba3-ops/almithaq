import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/sellers_data.dart';
import 'package:almithaq/data/model/sellersmodel.dart';
import 'package:get/get.dart';

class PharmsController extends GetxController {

  SellersData sellersData = SellersData(Get.find());

  List<SellersModel> data = [];

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  getPharms() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await sellersData.getPharms();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        List listdata = response['data'];
        data.addAll(listdata.map((e) => SellersModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }
 

  refreshPharms() {
    getPharms();
  }

  @override
  void onInit() {
    getPharms();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
