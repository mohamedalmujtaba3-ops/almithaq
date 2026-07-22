import 'package:almithaq/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomOptionsDialog extends StatelessWidget {
  final String title;
  final String middletxt;
  final Function onpressed1;
  final String btn1text;
  final Function onpressed2;
  final String btn2text;

  const CustomOptionsDialog(
      {Key? key,
      required this.title,
      required this.middletxt,
      required this.onpressed1,
      required this.btn1text,
      required this.onpressed2,
      required this.btn2text,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              color: AppColor.primaryColor,
                              letterSpacing: 0,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          middletxt,
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 16,
                              color: AppColor.grey2,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                onpressed1();
                              },
                              style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColor.primaryColor)),
                              child: Text(
                                btn1text,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                onpressed2();
                              },
                              style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColor.primaryColor)),
                              child: Text(
                                btn2text,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
  }
}

