import 'package:dictionary/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode4u/utils/k_utils.dart';

import '../../states/app_state.dart';
import '../../widgets/k_button.dart';

class CategoryContent extends StatelessWidget {
  const CategoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    AppState app = Get.find<AppState>();
    return Stack(
      children: [
        Positioned.fill(
          top: 80,
          left: 10,
          right: 10,
          bottom: 10,
          child: Container(
              margin: const EdgeInsets.only(top: 180),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KButton("alphabet".tr, () {
                      app.currentKey.value =
                          KUtil.isEn() ? 'data_alpha_en' : 'data_alpha';
                      app.switchScreen(Screen.level);
                    }),
                    KUtil.isEn()
                        ? Container()
                        : KButton("khmer_number".tr, () {
                            app.currentKey.value = 'data_khmer_number';
                            app.switchScreen(Screen.level);
                          }),
                    KButton("roman_number".tr, () {
                      app.currentKey.value = 'data_number';
                      app.switchScreen(Screen.level);
                    }),
                    KButton("alphabet_leg".tr, () {
                      app.currentKey.value = KUtil.isEn()
                          ? 'data_alpha_lower_en'
                          : 'data_alpha_leg';
                      app.switchScreen(Screen.level);
                    }),
                    KUtil.isEn()
                        ? Container()
                        : KButton("vowel".tr, () {
                            app.currentKey.value = 'data_vowel';
                            app.switchScreen(Screen.level);
                          }),
                    KUtil.isEn()
                        ? Container()
                        : KButton("independence_vowel".tr, () {
                            app.currentKey.value = 'data_independence_vowel';
                            app.switchScreen(Screen.level);
                          }),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
