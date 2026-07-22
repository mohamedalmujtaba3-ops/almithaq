import 'package:almithaq/controller/wallet/wallet_controller.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletTransferScreen extends StatelessWidget {
  const WalletTransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: const Text("تحويل رصيد", style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.transferFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Balance chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.thirdColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.account_balance_wallet, color: AppColor.primaryColor, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "رصيدك: ${controller.balance.toStringAsFixed(2)} جنيه",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                const Text("رقم تعريف المستخدم", style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.grey2)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.receiverIdController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "أدخل ID العميل",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColor.primaryColor),
                    ),
                    prefixIcon: const Icon(Icons.person, color: AppColor.primaryColor),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) return "أدخل رقم تعريف المستخدم";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                const Text("المبلغ المراد تحويله", style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.grey2)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.transferAmountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: "أدخل المبلغ",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColor.primaryColor),
                    ),
                    prefixIcon: const Icon(Icons.attach_money, color: AppColor.primaryColor),
                    suffixText: "جنيه",
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) return "أدخل المبلغ";
                    double? amount = double.tryParse(val);
                    if (amount == null || amount <= 0) return "أدخل مبلغاً صحيحاً";
                    if (amount > controller.balance) return "المبلغ يتجاوز رصيدك الحالي";
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: controller.transferBalance,
                    color: AppColor.primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: controller.statusRequest.toString().contains("loading")
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text("تأكيد التحويل", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
