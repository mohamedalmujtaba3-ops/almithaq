// import 'package:almithaq/controller/myfavoritecontroller.dart';
// import 'package:almithaq/core/class/handlingdataview.dart';
// import 'package:almithaq/core/constant/routes.dart';
// import 'package:almithaq/view/widget/customappbar.dart';
// import 'package:almithaq/view/widget/myfavorite/customlistfavoriteitems.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MyFavorite extends StatelessWidget {
//   const MyFavorite({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Get.put(MyFavoriteController());

//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: GetBuilder<MyFavoriteController>(
//             builder: ((controller) => ListView(children: [
//                   CustomAppBar(
//                     mycontroller: controller.search!,
//                     titleappbar: "البحث عن منتج",
//                     iconData: Icons.arrow_forward,
//                     // onPressedIcon: () {},
//                     onPressedSearch: () {
//                       controller.onSearchItems();
//                     },
//                     onChanged: (val) {
//                       controller.checkSearch(val);
//                     },
//                     onPressedIconFavorite: () {
//                       Get.offAllNamed(AppRoute.homepage);
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   HandlingDataView(
//                       statusRequest: controller.statusRequest,
//                       widget: GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: controller.data.length,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2, childAspectRatio: 0.7),
//                         itemBuilder: (context, index) {
//                           return CustomListFavoriteItems(
//                               itemsModel: controller.data[index]);
//                         },
//                       ))
//                 ]))),
//       ),
//     );
//   }
// }
