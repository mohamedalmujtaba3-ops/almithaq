import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/linkapi.dart';
import 'package:get/get.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData(this.crud);

  MyServices myServices = Get.find();

  

  postdata(String phone ,String password) async {

    var response = await crud.postData(AppLink.resetPassword, {
      "phone" : phone , 
      "password" : password,
    });
    return response.fold((l) => l, (r) => r);

  }
}
