import 'package:dictionary/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  KButton("ព្យញ្ជនៈ", () {
                    Get.find<AppState>().data.value = DataAlpha().d;
                    Get.find<AppState>().selectedContent.value = 2;
                    print('data is ${Get.find<AppState>().data.toString()}');
                  }),
                  KButton("លេខខ្មែរ", () {
                    Get.find<AppState>().selectedContent.value = 2;
                    Get.find<AppState>().data.value = DataNumber().d;
                  }),
                  KButton("លេខបារាំង", () {
                    Get.find<AppState>().selectedContent.value = 2;
                    Get.find<AppState>().data.value = DataNumber().d;
                  }),
                  KButton("ជើងព្យញ្ជនៈ", () {
                    Get.find<AppState>().data.value = DataAlphaLeg().d;
                    Get.find<AppState>().selectedContent.value = 2;
                  }),
                  KButton("ស្រៈ", () {
                    Get.find<AppState>().data.value = DataVowel().d;
                    Get.find<AppState>().selectedContent.value = 2;
                  }),
                  KButton("ស្រៈពេញតួ", () {
                    Get.find<AppState>().data.value = DataIndependenceVowel().d;
                    Get.find<AppState>().selectedContent.value = 2;
                  }),
                ],
              )),
        ),
      ],
    );
  }
}
