import 'package:almithaq/controller/wallet/wallet_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/functions/citybounds.dart';
import 'package:almithaq/view/screen/wallet/wallet_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(WalletController());
    return GetBuilder<WalletController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: const Text("المحفظة", style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: controller.statusRequest.toString().contains("loading")
            ? const Center(child: CircularProgressIndicator(color: AppColor.primaryColor))
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Balance Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: AppColor.gradientcolor1,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(0, 4))
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.account_balance_wallet, size: 48, color: Colors.white),
                        const SizedBox(height: 12),
                        const Text("رصيدك الحالي", style: TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 6),
                        Text(
                          "${NumberFormat('#,##0').format(controller.balance.ceil())} جنيه",
                          style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            Text("ID ${myServices.sharedPreferences.getString("id")}", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: myServices.sharedPreferences.getString("id")!));
                                Get.snackbar("تم النسخ", "تم نسخ رقم المحفظة");
                              },
                              icon: const Icon(Icons.copy, color: Colors.white),
                              tooltip: "نسخ",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Transfer button
                  OutlinedButton.icon(
                    onPressed: () {
                      Get.to(() => const WalletTransferScreen());
                    },
                    icon: const Icon(Icons.swap_horiz, color: AppColor.primaryColor),
                    label: const Text("تحويل رصيد لعميل آخر", style: TextStyle(color: AppColor.primaryColor)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColor.primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Top-up section title
                  const Text(
                    "تغذية الرصيد",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.grey2),
                  ),
                  const SizedBox(height: 12),

                  // Bank account card
                  if (controller.bankAccount.isNotEmpty)
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("رقم حساب بنكك", style: TextStyle(color: Colors.red, fontSize: 13)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.bankAccount,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.grey2),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: controller.bankAccountClipboard));
                                    Get.snackbar("تم النسخ", "تم نسخ رقم الحساب");
                                  },
                                  icon: const Icon(Icons.copy, color: AppColor.primaryColor),
                                  tooltip: "نسخ",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("رقم حساب فوري", style: TextStyle(color: Colors.blue, fontSize: 13)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.fawryAccount,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.grey2),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: controller.fawryAccountClipboard));
                                    Get.snackbar("تم النسخ", "تم نسخ رقم الحساب");
                                  },
                                  icon: const Icon(Icons.copy, color: AppColor.primaryColor),
                                  tooltip: "نسخ",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("رقم حساب أوكاش", style: TextStyle(color: Colors.green, fontSize: 13)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.ocashAccount,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.grey2),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: controller.ocashAccountClipboard));
                                    Get.snackbar("تم النسخ", "تم نسخ رقم الحساب");
                                  },
                                  icon: const Icon(Icons.copy, color: AppColor.primaryColor),
                                  tooltip: "نسخ",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),

                  // Screenshot upload
                  GestureDetector(
                    onTap: controller.pickScreenshot,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.primaryColor, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFFFF3EE),
                      ),
                      child: controller.screenshotFile == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_file, size: 40, color: AppColor.primaryColor),
                                SizedBox(height: 8),
                                Text("اضغط لرفع صورة إثبات التحويل", style: TextStyle(color: AppColor.primaryColor)),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(controller.screenshotFile!, fit: BoxFit.cover, width: double.infinity),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Confirm button
                  MaterialButton(
                    onPressed: controller.sendTopupRequest,
                    color: AppColor.primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: const Text("تأكيد التغذية", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
