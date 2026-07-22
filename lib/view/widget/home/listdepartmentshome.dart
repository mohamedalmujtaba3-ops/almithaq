import 'package:almithaq/controller/home_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDepartmentsHome extends GetView<HomeControllerImp> {
  const ListDepartmentsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Categories(
            link: AppRoute.restaurants,
            title: "المطاعم",
            icon: Icons.fastfood,
          ),
          const SizedBox(width: 10),
          Categories(
            link: AppRoute.supermarkets,
            title: "المتاجر",
            icon: Icons.shopping_cart_outlined,
          ),
          const SizedBox(width: 10),
          Categories(
            link: AppRoute.pharmspicklocation,
            title: "الصيدليات",
            icon: Icons.medication,
          ),
          const SizedBox(width: 10),
          Categories(
            link: AppRoute.otherorderstartinglocation,
            title: "طلب آخر",
            icon: Icons.more_horiz,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class Categories extends GetView {
  final String link;
  final String title;
  final IconData icon;
  const Categories(
      {Key? key,
      required this.link,
      required this.icon,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(link),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 78,
        child: Column(
          children: [
            Container(
              height: 62,
              width: 62,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                gradient: AppColor.gradientcolor2,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primaryColor.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 12,
                  color: AppColor.grey2,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
