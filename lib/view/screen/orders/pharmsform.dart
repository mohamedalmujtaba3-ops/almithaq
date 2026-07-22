import 'package:almithaq/controller/pharmsform_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/functions/validinput.dart';
import 'package:almithaq/view/widget/auth/custombuttonauth.dart';
import 'package:almithaq/view/widget/auth/customtextarea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PharmsForm extends StatefulWidget {
  PharmsForm({Key? key}) : super(key: key);

  @override
  State<PharmsForm> createState() => _PharmsFormState();
}

class _PharmsFormState extends State<PharmsForm> {
  @override
  Widget build(BuildContext context) {
    Get.put(PharmsFormController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text("تفاصيل الطلب",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColor.grey)),
      ),
      body: GetBuilder<PharmsFormController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(children: [
                  CustomTextarea(
                      hinttext: "الادوية والمستحضرات التي ترغب في طلبها وكمياتها",
                      labeltext: "الأدوية",
                      iconData: Icons.notes_sharp,
                      mycontroller: controller.medstext,
                      valid: (val) {
                        return validInput(val!, 7, 250, "text");
                      },
                      isNumber: false),

                  CustomTextarea(
                      hinttext: "الصيدليات المحتملة واي ملاحظات اخرى",
                      labeltext: "ملاحظة",
                      iconData: Icons.notes_sharp,
                      mycontroller: controller.notes,
                      valid: (val) {
                        return validInput(val!, 7, 250, "text");
                      },
                      isNumber: false),
                  const SizedBox(
                    height: 10,
                  ),
                  if (controller.rousheta != null)
                    Image.file(
                      controller.rousheta!,
                    ),

                  const SizedBox(
                    height: 20,
                  ),
                  CustomButtomAuth(
                      text: "إرسال الطلب",
                      onPressed: () {
                        controller.addOrderText();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            )),
      ),
    );
  }
}
