import 'package:almithaq/controller/checkout_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/functions/validinput.dart';
import 'package:almithaq/view/widget/auth/custombuttonauth.dart';
import 'package:almithaq/view/widget/auth/customtextarea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderForm extends StatefulWidget {
  OrderForm({Key? key}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  @override
  Widget build(BuildContext context) {
    final String orderprice = Get.arguments['priceorder'].toString();
    Get.put(CheckoutController());
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
      body: GetBuilder<CheckoutController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: ListView(children: [
                CustomTextarea(
                    hinttext: "وصف واضح ومختصر لعنوانك",
                    labeltext: "العنوان كتابة",
                    iconData: Icons.location_on_outlined,
                    mycontroller: controller.address,
                    valid: (val) {
                      return validInput(val!, 20, 250, "text");
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
                    Text(controller.delvprice == 0 ? "خطأ" : "${controller.delvprice}"),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("سعر الطلب",
                        style: TextStyle(color: Colors.black)),
                    const Spacer(),
                    Text(orderprice),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("الإجمالي",
                        style: TextStyle(color: Colors.black)),
                    const Spacer(),
                    Text(controller.delvprice == 0 ? "خطأ" : "${controller.delvprice + int.parse(orderprice)}"),
                  ],
                ),
                    
                const SizedBox(
                  height: 20,
                ),
                CustomButtomAuth(
                    text: "إرسال الطلب",
                    onPressed: () {
                      Get.defaultDialog(
                          title: "إرسال الطلب",
                          titleStyle: const TextStyle(
                              color: Color.fromARGB(255, 221, 134, 3),
                              fontWeight: FontWeight.bold),
                          middleText: "هل تريد تأكيد الطلب ؟ لا يمكن الغاء الطلب بعد موافقة مندوب التوصيل",
                          buttonColor: Color.fromARGB(255, 221, 134, 3),
                          cancelTextColor:
                              Color.fromARGB(255, 221, 134, 3),
                          textConfirm: "نعم",
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                              controller.checkout(orderprice, controller.userLat.toString(), controller.userLong.toString(), controller.delvprice.toString());
                          },
                          textCancel: "لا",
                          onCancel: () {
                            Get.back();
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
              ]),
            )),
      ),
    );
  }
}
