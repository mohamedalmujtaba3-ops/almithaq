import 'package:almithaq/controller/auth/codeandpass/verifycodeforgot_controller.dart';
import 'package:almithaq/core/constant/color.dart'; 
import 'package:almithaq/view/widget/auth/customtextbodyauth.dart'; 
import 'package:almithaq/view/widget/auth/customtexttitleauth.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerfiyCode extends StatefulWidget {
  const VerfiyCode({Key? key}) : super(key: key);

@override
  State<VerfiyCode> createState() => _VerifyCodeState();
}


class _VerifyCodeState extends State<VerfiyCode> {
  @override
  Widget build(BuildContext context) {
    VerifyCodeControllerImp controller =
        Get.put(VerifyCodeControllerImp());
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
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(children: [
          const SizedBox(height: 20),
          const CustomTextTitleAuth(text: "رمز التحقق"),
          const SizedBox(height: 10),
           CustomTextBodyAuth(
              text:
                  "أدخل الرمز الذي أرسل إلى ${controller.phone!}"),
          const SizedBox(height: 15),
            Directionality(
              textDirection: TextDirection.ltr,
              child: OtpTextField(
                
                  fieldWidth: 50.0,
                  borderRadius: BorderRadius.circular(20),
                  numberOfFields: 5,
                  borderColor:const  Color(0xFF512DA8),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                       controller.goToResetPassword(verificationCode) ; 
                  }, // end onSubmit
                ),
            ), 
          const SizedBox(height: 40),
          GetBuilder<VerifyCodeControllerImp>(
            builder: (controller) {
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
      ),
    );
  }
}
