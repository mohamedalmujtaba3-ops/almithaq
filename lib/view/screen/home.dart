import 'package:almithaq/controller/wallet/wallet_controller.dart';
import 'package:almithaq/view/screen/wallet/wallet_screen.dart';
import 'package:almithaq/view/widget/home/listrestoffershome.dart';
import 'package:almithaq/view/widget/home/listsuperoffershome.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:almithaq/controller/home_controller.dart';
import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/data/model/itemsmodel.dart';
import 'package:almithaq/linkapi.dart';
import 'package:almithaq/view/widget/customappbar.dart';
import 'package:almithaq/view/widget/home/customtitlehome.dart';
import 'package:almithaq/view/widget/home/listdepartmentshome.dart';
import 'package:almithaq/view/widget/home/listitemshome.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Get.put(HomeControllerImp());
    Get.put(WalletController());
    
    // if user is cominh from notification take him to orders page /// HERERE
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['pagename'] == "refreshorderspending") {
        Get.toNamed(AppRoute.orderspending);
      }
      if (message.data['pagename'] == "refreshordersarchive") {
        Get.toNamed(AppRoute.ordersarchive);
      }
      if (message.data['pagename'] == "refreshwallet") {
        Get.toNamed(AppRoute.wallet);
      }
    });


    return GetBuilder<HomeControllerImp>(
        builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                // AppBar with wallet button instead of reload
                CustomAppBar(
                  mycontroller: controller.search!,
                  titleappbar: "البحث عن منتج",
                  // onPressedIcon: () {},
                  onPressedSearch: () {
                    controller.onSearchItems();
                  },
                  onChanged: (val) {
                    controller.checkSearch(val);
                  },
                  onPressedIconRefresh: () {
                    Get.offAllNamed(AppRoute.homepage);
                  },
                ),
                // Wallet Balance Card
                GetBuilder<WalletController>(
                  builder: (walletCtrl) => GestureDetector(
                    onTap: () => Get.to(() => const WalletScreen()),
                    child: Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: AppColor.gradientcolor1,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.account_balance_wallet, color: Colors.white, size: 28),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("رصيد المحفظة", style: TextStyle(color: Colors.white70, fontSize: 12)),
                              Text(
                                "${NumberFormat('#,##0').format(walletCtrl.balance.ceil())} جنيه",
                                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                HandlingDataView(
                  statusRequest: controller.statusRequest,
                    widget: !controller.isSearch
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              CustomTitleHome(title: "الأقسام"),
                              ListDepartmentsHome(),
                              const Divider(),
                              if(controller.restaurantsoffers.isNotEmpty) 
                              CustomTitleHome(title: "عروض المطاعم"),
                              if(controller.restaurantsoffers.isNotEmpty) 
                              ListRestOffersHome(),
                              if(controller.restaurantsoffers.isNotEmpty) 
                              const Divider(),
                              if(controller.supermarketsoffers.isNotEmpty) 
                              CustomTitleHome(title: "عروض المتاجر"),
                              if(controller.supermarketsoffers.isNotEmpty) 
                              ListSuperOffersHome(),
                              if(controller.supermarketsoffers.isNotEmpty) 
                              const Divider(),
                              CustomTitleHome(title: "الأكثر مبيعاً"),
                              ListItemsHome(),
                            ],
                          )
                        : ListItemsSearch(listdatamodel: controller.listdata)
                        )
              ],
            )));
  }
}



class ListItemsSearch extends GetView<HomeControllerImp> {
  final List<ItemsModel> listdatamodel;
  const ListItemsSearch({Key? key, required this.listdatamodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listdatamodel.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              controller.goToPageProductDetails(listdatamodel[index]);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Card(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        child: CachedNetworkImage(
                            imageUrl:
                                "${AppLink.imagestItems}/${listdatamodel[index].itemsImage}")),
                    Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text(listdatamodel[index].itemsName!),
                          subtitle: Text(listdatamodel[index].sellerName!),
                        )),
                  ],
                ),
              )),
            ),
          );
        });
  }
}
