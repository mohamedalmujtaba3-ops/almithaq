import 'package:almithaq/controller/homescreen_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/view/widget/home/custombuttonappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomAppBarHome extends StatelessWidget {
  const CustomBottomAppBarHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
        builder: (controller) => BottomAppBar(
          height: MediaQuery.sizeOf(context).height / 9.5,
          color: AppColor.primaryColor,
            shape: CircularNotchedRectangle(),
            notchMargin: 30,
            child: Row(
              children: [
                const Spacer(),
                    CustomButtonAppBar(
                          textbutton: controller.bottomappbar[0]['title'],
                          icondata: controller.bottomappbar[0]['icon'],
                          onPressed: () {
                            controller.changePage(0);
                          },
                          active: controller.currentpage == 0 ? true : false),
                      CustomButtonAppBar(
                          textbutton: controller.bottomappbar[1]['title'],
                          icondata: controller.bottomappbar[1]['icon'],
                          onPressed: () {
                            controller.changePage(1);
                          },
                          active: controller.currentpage == 1 ? true : false),
                
              ],
            )));
  }
}
