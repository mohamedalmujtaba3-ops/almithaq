import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColor.primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColor.gradientcolor2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.person,
                            size: 44, color: AppColor.primaryColor),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              title: const Text("الملف الشخصي",
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        children: [
                          _profileTile(
                            icon: Icons.person_outline,
                            label: "الاسم",
                            value: myServices.sharedPreferences
                                .getString("username")
                                .toString(),
                          ),
                          const Divider(height: 1, indent: 56),
                          _profileTile(
                            icon: Icons.phone_enabled_outlined,
                            label: "الهاتف",
                            value: myServices.sharedPreferences
                                .getString("phone")
                                .toString(),
                          ),
                          const Divider(height: 1, indent: 56),
                          _profileTile(
                            icon: Icons.location_city_outlined,
                            label: "المدينة",
                            value: myServices.sharedPreferences
                                .getString("city")
                                .toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      color: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        Get.toNamed(AppRoute.editprofile);
                      },
                      child: const Text(
                        "تعديل الملف الشخصي",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileTile(
      {required IconData icon,
      required String label,
      required String value}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.thirdColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColor.primaryColor, size: 20),
      ),
      title: Text(label,
          style: const TextStyle(color: AppColor.grey, fontSize: 12)),
      subtitle: Text(value,
          style: const TextStyle(
              color: AppColor.grey2,
              fontWeight: FontWeight.bold,
              fontSize: 14)),
    );
  }
}
