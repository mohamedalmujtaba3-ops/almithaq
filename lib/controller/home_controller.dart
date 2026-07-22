import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/functions/handingdatacontroller.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:almithaq/data/datasource/home_data.dart';
import 'package:almithaq/data/model/itemsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class HomeController extends SearchMixController {
  initialData();
  getdata();
}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();

  late String username;
  late String id;
  late String lang;

  HomeData homedata = HomeData(Get.find());

  // List data = [];
  List items = [];
  List restaurantsoffers = [];
  List supermarketsoffers = [];
  // List items = [];

  @override
  initialData() {
    // myServices.sharedPreferences.clear() ;
    username = myServices.sharedPreferences.getString("username").toString();
    id = myServices.sharedPreferences.getString("id").toString();
  }

  @override
  void onInit() {
    search = TextEditingController();
    getdata();
    initialData();
    super.onInit();
  }

  @override
  getdata() async {
    statusRequest = StatusRequest.loading;
    var response = await homedata.getData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (response['items']['data'] != null) {
          items.addAll(response['items']['data']);
        }
        if (response['restoffers']['data'] != null) {
          restaurantsoffers.addAll(response['restoffers']['data']);
        }
        if (response['superoffers']['data'] != null) {
          supermarketsoffers.addAll(response['superoffers']['data']);
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  // @override
  // goToItems(categories, selectedCat, categoryid) {
  //   Get.toNamed(AppRoute.items, arguments: {
  //     "categories": categories,
  //     "selectedcat": selectedCat,
  //     "catid": categoryid
  //   });
  // }


  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }
}

class SearchMixController extends GetxController {
  List<ItemsModel> listdata = [];

  late StatusRequest statusRequest;
  HomeData homedata = HomeData(Get.find());

  searchData() async {
    statusRequest = StatusRequest.loading;
    var response = await homedata.searchData(search!.text);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listdata.clear();
        List responsedata = response['data'];
        listdata.addAll(responsedata.map((e) => ItemsModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  bool isSearch = false;
  TextEditingController? search;
  checkSearch(val) {
    if (val == "") {
      statusRequest = StatusRequest.none;
      isSearch = false;
    }
    update();
  }

  onSearchItems() {
    isSearch = true;
    searchData();
    update();
  }
}
