import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/linkapi.dart';
import 'package:get/get.dart';

class CheckPhoneData {
  Crud crud;
  CheckPhoneData(this.crud);

  MyServices myServices = Get.find();



  postdata(String phone) async {

    var response = await crud.postData(AppLink.checkPhoneForgot, {
      "phone" : phone,
    });
    return response.fold((l) => l, (r) => r);
    
  }
}
