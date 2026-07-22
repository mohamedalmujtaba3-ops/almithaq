import 'package:almithaq/controller/otherorderform_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/functions/validinput.dart';
import 'package:almithaq/view/widget/auth/custombuttonauth.dart';
import 'package:almithaq/view/widget/auth/customtextarea.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OtherOrderForm extends StatefulWidget {
  OtherOrderForm({Key? key}) : super(key: key);

  @override
  State<OtherOrderForm> createState() => _OtherOrderFormState();
}

class _OtherOrderFormState extends State<OtherOrderForm> {
  @override
  Widget build(BuildContext context) {
    Get.put(OtherOrdersFormController());
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
      body: GetBuilder<OtherOrdersFormController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(children: [
                  CustomTextarea(
                      hinttext: "صف الطلب الذي ترغب في توصيله",
                      labeltext: "وصف الطلب",
                      iconData: FontAwesomeIcons.cube,
                      mycontroller: controller.desc,
                      valid: (val) {
                        return validInput(val!, 7, 250, "text");
                      },
                      isNumber: false),

                  CustomTextarea(
                      hinttext: "وصف واضح ومختصر لمكان الطلب و وجهة الطلب",
                      labeltext: "المكان والوجهة",
                      iconData: Icons.location_on_outlined,
                      mycontroller: controller.address,
                      valid: (val) {
                        return validInput(val!, 7, 250, "text");
                      },
                      isNumber: false),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("سعر التوصيل",
                          style: TextStyle(color: Colors.black)),
                      const Spacer(),
                      Text(controller.delvprice == 0 ? "خطأ" : "${controller.delvprice}",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  CustomButtomAuth(
                      text: "إرسال الطلب",
                      onPressed: () {
                        controller.addOrder();
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
