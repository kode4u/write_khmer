import 'dart:ui';

import 'package:dictionary/widgets/k_button.dart';
import 'package:dictionary/widgets/k_button_2.dart';
import 'package:dictionary/widgets/k_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kode4u/utils/k_utils.dart';
import 'package:lottie/lottie.dart';

import '../screens/main/main_screen.dart';
import '../services/api.dart';
import '../states/app_state.dart';

class KUserInput extends StatefulWidget {
  final VoidCallback onClose;

  const KUserInput({
    super.key,
    required this.onClose,
  });

  @override
  KUserInputState createState() => KUserInputState();
}

class KUserInputState extends State<KUserInput> {
  TextEditingController username = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              width: 300,
              height: 200,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 300,
                    height: 140,
                    child: KContainer(),
                  ),
                  Positioned(
                    top: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "username".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sr",
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 42,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: TextField(
                        controller: username,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: KUtil.isEn() ? 'ChangaOne' : 'Sr'),
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -16,
                    right: -16,
                    child: KButton2(
                      "X",
                      marginTop: 14,
                      width: 48,
                      height: 48,
                      widget.onClose,
                    ),
                  ),
                  Positioned(
                    bottom: 26,
                    right: 0,
                    left: 0,
                    child: KButton2(
                      "ok".tr,
                      marginTop: 14,
                      width: 96,
                      height: 48,
                      () {
                        if (username.text.isNotEmpty) {
                          createUser(0, username.text);
                        }
                        if (Get.find<AppState>().user.isNotEmpty) {
                          Get.find<AppState>().switchScreen(Screen.category);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
