import 'package:almithaq/controller/homescreen_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/view/widget/home/custombottomappbarhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
        builder: (controller) => Scaffold(
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: FloatingActionButton(
                  shape: CircleBorder(),
                  backgroundColor: AppColor.primaryColor,
                    onPressed: () {
                      Get.toNamed(AppRoute.cart) ; 
                    },
                    child: const Icon(Icons.shopping_basket_outlined), foregroundColor: Colors.white,),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startDocked,
              bottomNavigationBar: const CustomBottomAppBarHome(),
              body: controller.listPage.elementAt(controller.currentpage),
            ));
  }
}
