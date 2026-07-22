import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/linkapi.dart';
import 'package:get/get.dart';

class VerifyCodeForgetPasswordData {
  Crud crud;
  VerifyCodeForgetPasswordData(this.crud);

  MyServices myServices = Get.find();



  postdata(String phone ,String verifycode) async {

    var response = await crud.postData(AppLink.verifycodeforgetpassword, {
      "phone" : phone, 
      "verifycode" : verifycode,
    });
    return response.fold((l) => l, (r) => r);

  }

   resendData(String phone) async {
      var response = await crud.postData(AppLink.resend, {
        "phone": phone,
        });
      return response.fold((l) => l, (r) => r);
    }
  
}
