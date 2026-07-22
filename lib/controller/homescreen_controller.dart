import 'package:almithaq/view/screen/home.dart';
import 'package:almithaq/view/screen/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;

  List<Widget> listPage = [
    const HomePage(),
    Settings()
  ];

  List bottomappbar = [
    {"title": "home", "icon": Icons.home},
    {"title": "settings", "icon": Icons.menu},
  ];

  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
