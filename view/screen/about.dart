import 'package:almithaq/core/constant/color.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: const Text("عن الميثاق دليفري",
            style: TextStyle(color: Colors.white, fontSize: 14)),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColor.gradientcolor1),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 10),
            // Logo / icon area
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.motorcycle,
                    size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "الميثاق دليفري",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
            const Center(
              child: Text(
                "سرعة وثقة !",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),

            _section(
              title: "عن الميثاق",
              icon: Icons.info_outline,
              body:
                  "نحن شركة الميثاق لخدمات التوصيل المحدودة، شركة سودانية متخصصة في تقديم حلول التوصيل والخدمات اللوجستية للأفراد والشركات والمتاجر. نعمل على توفير خدمة سريعة وآمنة وموثوقة لنقل المستندات والطرود والطلبات المختلفة، مع التركيز على جودة الخدمة ورضا العملاء.\n\nنسعى إلى تسهيل عمليات التوصيل وربط التجار والعملاء بمندوبي التوصيل من خلال حلول عملية تواكب احتياجات السوق.",
            ),
            const SizedBox(height: 12),
            _section(
              title: "رؤيتنا",
              icon: Icons.visibility_outlined,
              body:
                  "أن نكون الخيار الأول والرائد في خدمات التوصيل والخدمات اللوجستية في السودان، من خلال تقديم خدمات احترافية تعتمد على السرعة والأمان والتقنيات الحديثة.",
            ),
            const SizedBox(height: 12),
            _section(
              title: "رسالتنا",
              icon: Icons.flag_outlined,
              body:
                  "تقديم خدمات توصيل موثوقة وفعالة تلبي احتياجات عملائنا وتساعدهم على إنجاز أعمالهم بسهولة، مع الالتزام بالمصداقية والجودة والاحترافية في جميع مراحل الخدمة.",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _section(
      {required String title,
      required IconData icon,
      required String body}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: AppColor.primaryColor, size: 20),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ],
            ),
            const Divider(height: 16),
            Text(body,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColor.grey2,
                    fontSize: 14,
                    height: 1.7)),
          ],
        ),
      ),
    );
  }
}
