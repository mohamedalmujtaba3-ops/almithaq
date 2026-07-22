import 'package:almithaq/controller/pharmsform_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/functions/validinput.dart';
import 'package:almithaq/view/widget/auth/custombuttonauth.dart';
import 'package:almithaq/view/widget/auth/customtextarea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PharmsFormRousheta extends StatefulWidget {
  PharmsFormRousheta({Key? key}) : super(key: key);

  @override
  State<PharmsFormRousheta> createState() => _PharmsFormRoushetaState();
}

class _PharmsFormRoushetaState extends State<PharmsFormRousheta> {
  @override
  Widget build(BuildContext context) {
    Get.put(PharmsFormController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: const Text("تفاصيل الطلب",
            style: TextStyle(color: Colors.white, fontSize: 14)),
      ),
      body: GetBuilder<PharmsFormController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
              child: Form(
                key: controller.formstate,
                child: ListView(children: [
                  CustomTextarea(
                      hinttext:
                          "الصيدليات المحتملة والعناصر المطلوبة من الروشتة وكميتها",
                      labeltext: "ملاحظة",
                      iconData: Icons.notes_sharp,
                      mycontroller: controller.notes,
                      valid: (val) {
                        return validInput(val!, 7, 300, "text");
                      },
                      isNumber: false),
                  const SizedBox(height: 16),

                  // Modern image upload field
                  const Text("صورة الروشتة",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.grey2,
                          fontSize: 13)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      controller.chooseImage();
                      controller.update();
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor.primaryColor, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFFFF3EE),
                      ),
                      child: controller.rousheta == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_file,
                                    size: 40, color: AppColor.primaryColor),
                                SizedBox(height: 8),
                                Text("اضغط لرفع صورة الروشتة",
                                    style: TextStyle(
                                        color: AppColor.primaryColor)),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(controller.rousheta!,
                                  fit: BoxFit.cover,
                                  width: double.infinity),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  CustomButtomAuth(
                      text: "إرسال الطلب",
                      onPressed: () {
                        controller.addOrderRousheta();
                      }),
                  const SizedBox(height: 10),
                ]),
              ),
            )),
      ),
    );
  }
}
