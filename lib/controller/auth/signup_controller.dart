import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/data/datasource/auth/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController repassword;
  late TextEditingController city;
  

   StatusRequest statusRequest = StatusRequest.none;

  SignupData signupData = SignupData(Get.find());

  List data = [];

  @override
  signUp() async {
    if (formstate.currentState!.validate()) {
      if(city.text.isEmpty || city.text == "" || city.text == "0") {
        return Get.snackbar("إختر المدينة", "حقل المدينة لا يمكن أن يترك فارغاً");
      }
      if (password.text == repassword.text) {
        statusRequest = StatusRequest.loading; 
        update(); 
        var response = await signupData.postdata(
            username.text, password.text, phone.text, city.text);
        print("=============================== Controller $response ");
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            // data.addAll(response['data']);
            Get.offNamed(AppRoute.verfiyCodeSignUp, preventDuplicates: false, arguments: {
              "phone" : phone.text
            });
          } else {
            Get.defaultDialog(title: "خطأ" , middleText: "رقم الهاتف موجود مسبقاً") ; 
            statusRequest = StatusRequest.failure;
          }
        }
        update();
      } else {
          Get.defaultDialog(title: "خطأ" , middleText: "كلمات المرور غير متطابقة") ; 
      }
    } else {
      
    }
  }

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    username = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    repassword = TextEditingController();
    city = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    phone.dispose();
    password.dispose();
    repassword.dispose();
    city.dispose();
    super.dispose();
  }
}
