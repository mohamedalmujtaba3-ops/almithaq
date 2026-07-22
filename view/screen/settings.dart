import 'package:almithaq/controller/settings_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/imgaeasset.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.put(SettingsController());
    MyServices myServices = Get.find();

    return ListView(
      children: [
        // Header with gradient
        Container(
          height: Get.width / 2.5,
          decoration: const BoxDecoration(
            gradient: AppColor.gradientcolor2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(AppImageAsset.avatar),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                myServices.sharedPreferences
                    .getString("username")
                    .toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
        ),

        // Menu items
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(
            children: [
              _menuCard(items: [
                _menuItem(
                  icon: Icons.pending_outlined,
                  title: "الطلبات الغير مكتملة",
                  onTap: () => Get.toNamed(AppRoute.orderspending),
                ),
                _menuItem(
                  icon: Icons.check_circle_outline,
                  title: "الطلبات المكتملة",
                  onTap: () => Get.toNamed(AppRoute.ordersarchive),
                  showDivider: false,
                ),
              ]),
              const SizedBox(height: 12),
              _menuCard(items: [
                _menuItem(
                  icon: Icons.person_outlined,
                  title: "الملف الشخصي",
                  onTap: () => Get.toNamed(AppRoute.viewprofile),
                ),
                _menuItem(
                  icon: Icons.help_outline_rounded,
                  title: "من نحن",
                  onTap: () => Get.toNamed(AppRoute.about),
                ),
                _menuItem(
                  icon: Icons.phone_callback_outlined,
                  title: "إتصل بنا",
                  onTap: () =>
                      launchUrl(Uri.parse("https://wa.me/249116920775")),
                  showDivider: false,
                ),
              ]),
              const SizedBox(height: 12),
              _menuCard(items: [
                _menuItem(
                  icon: Icons.exit_to_app,
                  title: "تسجيل الخروج",
                  onTap: () => controller.logout(),
                  color: Colors.red,
                  showDivider: false,
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _menuCard({required List<Widget> items}) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(mainAxisSize: MainAxisSize.min, children: items),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
    bool showDivider = true,
  }) {
    final itemColor = color ?? AppColor.grey2;
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color != null
                  ? color.withOpacity(0.1)
                  : AppColor.thirdColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: itemColor, size: 20),
          ),
          title: Text(title,
              style: TextStyle(color: itemColor, fontSize: 14)),
          trailing:
              Icon(Icons.chevron_left, color: AppColor.grey, size: 20),
        ),
        if (showDivider)
          const Divider(height: 1, indent: 56, endIndent: 16),
      ],
    );
  }
}
