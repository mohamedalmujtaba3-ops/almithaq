import 'package:almithaq/core/class/handlingdataview.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/functions/validinput.dart';
import 'package:almithaq/controller/auth/edit_profile_controller.dart';
import 'package:almithaq/view/widget/auth/custombuttonauth.dart';
import 'package:almithaq/view/widget/auth/customtextformauth.dart';
import 'package:almithaq/view/widget/auth/textsignup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EditProfileControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text("تعديل الملف الشخصي",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColor.primaryColor, fontSize: 20)),
      ),
      body: Container(
          child: GetBuilder<EditProfileControllerImp>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,

            widget: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 6, 20, "text");
                    },
                    mycontroller: controller.username,
                    hinttext: "إسم المستخدم",
                    iconData: Icons.person_outline,
                    labeltext: "إسم المستخدم",
                  ),

                  DropdownMenu(
                      controller: controller.city,
                      trailingIcon: const Icon(
                        Icons.location_city,
                      ),
                      initialSelection: controller.myServices.sharedPreferences.getString("city").toString(),
                      width: Get.width - 50,
                      inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      label: const ListTile(
                        title: Text("إختر المدينة"),
                      ),
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                            value: "بورتسودان",
                            label: "بورتسودان",
                            labelWidget: ListTile(
                              title: Text("بورتسودان"),
                            )),
                        DropdownMenuEntry(
                            value: "عطبرة",
                            label: "عطبرة",
                            labelWidget: ListTile(
                              title: Text("عطبرة"),
                            )),
                        DropdownMenuEntry(
                            value: "مدني",
                            label: "مدني",
                            labelWidget: ListTile(
                              title: Text("مدني"),
                            )),
                        DropdownMenuEntry(
                            value: "القضارف",
                            label: "القضارف",
                            labelWidget: ListTile(
                              title: Text("القضارف"),
                            )),
                        DropdownMenuEntry(
                            value: "كسلا",
                            label: "كسلا",
                            labelWidget: ListTile(
                              title: Text("كسلا"),
                            )),
                        DropdownMenuEntry(
                            value: "مروي",
                            label: "مروي",
                            labelWidget: ListTile(
                              title: Text("مروي"),
                            )),
                        DropdownMenuEntry(
                            value: "أم درمان",
                            label: "أم درمان",
                            labelWidget: ListTile(
                              title: Text("أم درمان"),
                            )),
                        DropdownMenuEntry(
                            value: "شندي",
                            label: "شندي",
                            labelWidget: ListTile(
                              title: Text("شندي"),
                            )),
                        DropdownMenuEntry(
                            value: "كريمة",
                            label: "كريمة",
                            labelWidget: ListTile(
                              title: Text("كريمة"),
                            )),
                        DropdownMenuEntry(
                            value: "الدامر",
                            label: "الدامر",
                            labelWidget: ListTile(
                              title: Text("الدامر"),
                            )),
                        DropdownMenuEntry(
                            value: "بحري",
                            label: "بحري",
                            labelWidget: ListTile(
                              title: Text("بحري"),
                            )),
                        DropdownMenuEntry(
                            value: "الخرطوم",
                            label: "الخرطوم",
                            labelWidget: ListTile(
                              title: Text("الخرطوم"),
                            )),
                        DropdownMenuEntry(
                            value: "الحصاحيصا",
                            label: "الحصاحيصا",
                            labelWidget: ListTile(
                              title: Text("الحصاحيصا"),
                            )),
                        DropdownMenuEntry(
                            value: "المناقل",
                            label: "المناقل",
                            labelWidget: ListTile(
                              title: Text("المناقل"),
                            )),
                        DropdownMenuEntry(
                            value: "سنجة",
                            label: "سنجة",
                            labelWidget: ListTile(
                              title: Text("سنجة"),
                            )),
                        DropdownMenuEntry(
                            value: "سنار",
                            label: "سنار",
                            labelWidget: ListTile(
                              title: Text("سنار"),
                            )),
                        DropdownMenuEntry(
                            value: "الدويم",
                            label: "الدويم",
                            labelWidget: ListTile(
                              title: Text("الدويم"),
                            )),
                        DropdownMenuEntry(
                            value: "كوستي",
                            label: "كوستي",
                            labelWidget: ListTile(
                              title: Text("كوستي"),
                            )),
                        DropdownMenuEntry(
                            value: "ربك",
                            label: "ربك",
                            labelWidget: ListTile(
                              title: Text("ربك"),
                            )),
                        DropdownMenuEntry(
                            value: "دنقلا",
                            label: "دنقلا",
                            labelWidget: ListTile(
                              title: Text("دنقلا"),
                            )),
                        DropdownMenuEntry(
                            value: "الابيض",
                            label: "الابيض",
                            labelWidget: ListTile(
                              title: Text("الابيض"),
                            )),
                        DropdownMenuEntry(
                            value: "الدمازين",
                            label: "الدمازين",
                            labelWidget: ListTile(
                              title: Text("الدمازين"),
                            )),
                        DropdownMenuEntry(
                            value: "الفاشر",
                            label: "الفاشر",
                            labelWidget: ListTile(
                              title: Text("الفاشر"),
                            )),
                        DropdownMenuEntry(
                            value: "الضعين",
                            label: "الضعين",
                            labelWidget: ListTile(
                              title: Text("الضعين"),
                            )),
                        DropdownMenuEntry(
                            value: "النهود",
                            label: "النهود",
                            labelWidget: ListTile(
                              title: Text("النهود"),
                            )),
                        DropdownMenuEntry(
                            value: "الجنينة",
                            label: "الجنينة",
                            labelWidget: ListTile(
                              title: Text("الجنينة"),
                            )),
                        DropdownMenuEntry(
                            value: "نيالا",
                            label: "نيالا",
                            labelWidget: ListTile(
                              title: Text("نيالا"),
                            )),
                        DropdownMenuEntry(
                            value: "حلفا الجديدة",
                            label: "حلفا الجديدة",
                            labelWidget: ListTile(
                              title: Text("حلفا الجديدة"),
                            )),

                      ]),
                  const SizedBox(height: 20,),
                  CustomTextFormAuth(
                    isNumber: true,
                    valid: (val) {
                      return validInput(val!, 10, 10, "phone");
                    },
                    mycontroller: controller.phone,
                    hinttext: "0xxxxxxxxx",
                    iconData: Icons.phone_outlined,
                    labeltext: "رقم الهاتف",
                  ),
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput("xxxxxxxx", 8, 30, "password");
                    },
                    mycontroller: controller.password,
                    hinttext: "إتركها فارغة إن لم ترد تغييرها",
                    iconData: Icons.lock_outline,
                    labeltext: "كلمة المرور",
                  ),
                  CustomButtomAuth(
                      text: "حفظ التعديل",
                      onPressed: () {
                        controller.editData();
                      }),
                  const SizedBox(height: 20),
                  CustomTextSignUpOrSignIn(
                    textone: "",
                    texttwo: "إلغاء",
                    onTap: () {
                      Get.back();
                    },
                  ),
                ]),
              ),
            )),
      )),
    );
  }
}
