import 'package:almithaq/data/datasource/auth/codeandpass/checkphoneforgot.dart';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ForgetPasswordController extends GetxController {
  checkemail(); 
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  
  CheckPhoneData checkPhoneData  = CheckPhoneData(Get.find()) ; 

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  
  StatusRequest statusRequest  = StatusRequest.none ;  

  late TextEditingController phone;

  @override
  checkemail() async  {
    if (formstate.currentState!.validate()){
      statusRequest = StatusRequest.loading; 
      update() ; 
      var response = await checkPhoneData.postdata(phone.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.verfiyCode , preventDuplicates: false, arguments: {
            "phone" : phone.text
          });
        } else {
          Get.defaultDialog(title: "خطأ" , middleText: "رقم الهاتف غير موجود"); 
        }
      }
      update();
    }
  }

 
  @override
  void onInit() {
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }
}
