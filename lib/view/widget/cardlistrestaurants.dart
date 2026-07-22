import 'package:almithaq/controller/restaurants_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/model/sellersmodel.dart';
import 'package:almithaq/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardRestaurantsList extends GetView<RestaurantsController> {
  final SellersModel listdata;
  final String? search;
  final String? city;
  const CardRestaurantsList(this.search, this.city, {Key? key, required this.listdata}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    
    return listdata.sellerCity!.contains(myServices.sharedPreferences.getString("city").toString()) ?
    // if there is no search
    search == "" ? 
    
    Container(
      decoration: BoxDecoration(
          color: listdata.sellerStatus == "1" ? Colors.white : const Color.fromARGB(255, 195, 195, 195),
          border: const Border.symmetric(
              horizontal: BorderSide(color: Colors.grey, width: 0.5))),
      child: ListTile(
        onTap: () {
            if(listdata.sellerStatus == "1") {
              Get.toNamed(AppRoute.items, arguments: {
                "sellermodel" : listdata
              });
            } else {
              Get.snackbar("عفواً", "المطعم قد أغلق الطلبات للوقت الحالي.");
            }
          },
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network("${AppLink.imageststatic}/sellers/${listdata.sellerLogo}", 
            width: 50,
            height: Get.height,)),
        ),
        title: Text("${listdata.sellerName}",
            style: const TextStyle(
                color: AppColor.secondColor,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 11,
            ),
            Expanded(
              child: Text("${listdata.sellerAddress}",
                  style:
                      const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 50,
          child: Icon(Icons.keyboard_double_arrow_left_sharp,),
        ),
      ),
    ) 
    
    // if there is a restaurant that match search text
    : listdata.sellerName.toString().contains(search!) ?
    
    Container(
      decoration: BoxDecoration(
          color: listdata.sellerStatus == "1" ? Colors.white : const Color.fromARGB(255, 195, 195, 195),
          border: Border.symmetric(
              horizontal: BorderSide(color: Colors.grey, width: 0.5))),
      child: ListTile(
        onTap: () {
          if(listdata.sellerStatus == "1") {
            Get.toNamed(AppRoute.items, arguments: { // change route
              "sellermodel" : listdata
            });
          } else {
            Get.snackbar("عفواً", "المطعم قد أغلق الطلبات للوقت الحالي.");
          }
        },
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network("${AppLink.imageststatic}/sellers/${listdata.sellerLogo}", 
            width: 50,
            height: Get.height,)),
        ),
        title: Text("${listdata.sellerName}",
            style: const TextStyle(
                color: AppColor.secondColor,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 11,
            ),
            Expanded(
              child: Text("${listdata.sellerAddress}",
                  style:
                      const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 50,
          child: Icon(Icons.keyboard_double_arrow_left_sharp,),
        ),
      ),
    ) 
    
    // if the search doesn' match anything
    : const SizedBox(height: 0.1,)

    
    //if there are no records in user city
    : const SizedBox(height: 0.1,);

  }
}
