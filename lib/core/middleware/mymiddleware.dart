import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    final step = myServices.sharedPreferences.getString("step");
    final token = myServices.sharedPreferences.getString("jwt_token");

    // If JWT is missing or empty, force login regardless of step
    if (token == null || token.isEmpty) {
      if (route != AppRoute.login) {
        return const RouteSettings(name: AppRoute.login);
      }
      return null;
    }

    if (step == "2") {
      return const RouteSettings(name: AppRoute.homepage);
    }
    if (step == "1") {
      return const RouteSettings(name: AppRoute.login);
    }

    return null;
  }
}
