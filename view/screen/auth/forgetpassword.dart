import 'package:almithaq/controller/auth/codeandpass/forgetpassword_controller.dart';
import 'package:almithaq/core/functions/validinput.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/view/widget/auth/custombuttonauth.dart';
import 'package:almithaq/view/widget/auth/customtextbodyauth.dart';
import 'package:almithaq/view/widget/auth/customtextformauth.dart';
import 'package:almithaq/view/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//check email
class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text("نسيت كلمة المرور",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColor.grey, fontSize: 20)),
      ),
      body: GetBuilder<ForgetPasswordControllerImp>(
          builder: (controller) =>  
          HandlingDataRequest( statusRequest: controller.statusRequest, widget: 
           Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Form(
                    key: controller.formstate,
                    child: ListView(children: [
                      const SizedBox(height: 20),
                      const CustomTextTitleAuth(text: "فحص رقم الهاتف"),
                      const SizedBox(height: 10),
                      const CustomTextBodyAuth(
                          text: "الرجاء ادخال الهاتف لتلقي رمز التحقق"),
                      const SizedBox(height: 15),
                      CustomTextFormAuth(
                        isNumber: true,
                        valid: (val) {
                          return validInput(val!, 10, 10, "phone");
                        },
                        mycontroller: controller.phone,
                        hinttext: "0xxxxxxxxx",
                        iconData: Icons.phone_outlined,
                        labeltext: "رقم الهاتف",
                      ),
                      CustomButtomAuth(
                          text: "تحقق",
                          onPressed: () {
                            controller.checkemail();
                          }),
                      const SizedBox(height: 40),
                    ]),
                  ),
                ))),
    );
  }
}
