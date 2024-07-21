import 'package:dictionary/data/data.dart';
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
    return Stack(
      children: [
        Positioned.fill(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10,
          child: Container(
              margin: const EdgeInsets.only(top: 96),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KButton("alphabet".tr, () {
                    Get.find<AppState>().data.value =
                        KUtil.isEn() ? DataAlphaEn().d : DataAlpha().d;
                    Get.find<AppState>().switchScreen(Screen.level);
                  }),
                  KUtil.isEn()
                      ? Container()
                      : KButton("khmer_number".tr, () {
                          Get.find<AppState>().data.value = DataKhmerNumber().d;
                          Get.find<AppState>().switchScreen(Screen.level);
                        }),
                  KButton("roman_number".tr, () {
                    Get.find<AppState>().data.value = DataNumber().d;
                    Get.find<AppState>().switchScreen(Screen.level);
                  }),
                  KButton("alphabet_leg".tr, () {
                    Get.find<AppState>().data.value =
                        KUtil.isEn() ? DataAlphaEnLower().d : DataAlphaLeg().d;
                    Get.find<AppState>().switchScreen(Screen.level);
                  }),
                  KUtil.isEn()
                      ? Container()
                      : KButton("vowel".tr, () {
                          Get.find<AppState>().data.value = DataVowel().d;
                          Get.find<AppState>().switchScreen(Screen.level);
                        }),
                  KUtil.isEn()
                      ? Container()
                      : KButton("independence_vowel".tr, () {
                          Get.find<AppState>().data.value =
                              DataIndependenceVowel().d;
                          Get.find<AppState>().switchScreen(Screen.level);
                        }),
                ],
              )),
        ),
      ],
    );
  }
}
