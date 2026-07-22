import 'package:almithaq/controller/auth/login_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/functions/alertexitapp.dart';
import 'package:almithaq/core/functions/validinput.dart';
import 'package:almithaq/view/widget/auth/custombuttonauth.dart';
import 'package:almithaq/view/widget/auth/customtextformauth.dart';
import 'package:almithaq/view/widget/auth/customtexttitleauth.dart';
import 'package:almithaq/view/widget/auth/logoauth.dart';
import 'package:almithaq/view/widget/auth/textsignup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text('تسجيل الدخول',
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColor.grey)),
      ),
      body: WillPopScope(
          onWillPop: alertExitApp,
          child: GetBuilder<LoginControllerImp>(
            builder: (controller) => HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Form(
                    key: controller.formstate,
                    child: ListView(children: [
                      const LogoAuth(),
                      const SizedBox(height: 10),
                      CustomTextTitleAuth(text: "تسجيل الدخول"),
                      const SizedBox(height: 20),
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
                      GetBuilder<LoginControllerImp>(
                        builder: (controller) => CustomTextFormAuth(
                          obscureText: controller.isshowpassword,
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!, 8, 30, "password");
                          },
                          mycontroller: controller.password,
                          hinttext: "أدخل كلمة المرور",
                          iconData: Icons.lock_outline,
                          labeltext: "كلمة المرور",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.goToForgetPassword();
                        },
                        child: const Text(
                          "نسيت كلمة المرور",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      CustomButtomAuth(
                          text: "تسجيل الدخول",
                          onPressed: () {
                            controller.login();
                          }),
                      const SizedBox(height: 40),
                      CustomTextSignUpOrSignIn(
                        textone: "  ليس لديك حساب ؟  ",
                        texttwo: "إنشاء حساب",
                        onTap: () {
                          controller.goToSignUp();
                        },
                      )
                    ]),
                  ),
                )),
          )),
    );
  }
}
