import 'package:almithaq/controller/auth/codeandpass/verfiycodesignup_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/view/widget/auth/customtextbodyauth.dart';
import 'package:almithaq/view/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerfiyCodeSignUp extends StatefulWidget {
  const VerfiyCodeSignUp({Key? key}) : super(key: key);

@override
  State<VerfiyCodeSignUp> createState() => _VerifyCodeSignUpState();
}


class _VerifyCodeSignUpState extends State<VerfiyCodeSignUp> {
  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeSignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text('تأكيد رقم الهاتف',
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColor.grey)),
      ),
      body: GetBuilder<VerifyCodeSignUpControllerImp>(
          builder: (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: ListView(children: [
                  const SizedBox(height: 20),
                  const CustomTextTitleAuth(text: "رمز التأكيد"),
                  const SizedBox(height: 10),
                    CustomTextBodyAuth(
                      text:
                          "أدخل الرمز الذي أرسل إلى ${controller.phone}"),
                  const SizedBox(height: 15),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: OtpTextField(
                      fieldWidth: 50.0,
                      borderRadius: BorderRadius.circular(20),
                      numberOfFields: 5,
                      borderColor: const Color(0xFF512DA8),
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                      },
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) {
                        controller.goToSuccessSignUp(verificationCode);
                      }, // end onSubmit
                    ),
                  ),
                  const SizedBox(height: 40),
                  Builder(
                    builder: (context) {
                      final remaining = controller.remainingSeconds;
                      return InkWell(
                        onTap: remaining == 0 ? () => controller.reSend() : null,
                        child: Center(
                          child: Text(
                            remaining == 0 ? "إعادة إرسال الرمز" : "إعادة الإرسال بعد $remaining ثانية",
                            style: TextStyle(color: AppColor.primaryColor, fontSize: 18),
                          ),
                        ),
                      );
                    },
                  )
                ]),
              ))),
    );
  }
}
