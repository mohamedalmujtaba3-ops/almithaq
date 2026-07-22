import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/linkapi.dart';
import 'package:almithaq/core/class/crud.dart';
import 'package:get/get.dart';

class UpdateDelvLocation {
  Crud crud;
  UpdateDelvLocation(this.crud);

  MyServices myServices = Get.find();

  UpdateLocation(String orderid) async {

  var response = await crud.postData(AppLink.getdelvlocation, {"id": orderid});
    return response.fold((l) => l, (r) => r);

  }

}