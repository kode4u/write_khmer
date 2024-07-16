import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../states/app_state.dart';
import '../../widgets/k_button.dart';

class CategoryContent extends StatelessWidget {
  const CategoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    Get.find<AppState>().selectedContent.value = 2;
                  }),
                  KButton("លេខ", () {
                    Get.find<AppState>().selectedContent.value = 2;
                  }),
                  KButton("ជើងព្យញ្ជនៈ", () {
                    Get.find<AppState>().selectedContent.value = 2;
                  }),
                  KButton("ស្រៈ", () {
                    Get.find<AppState>().selectedContent.value = 2;
                  }),
                  KButton("ស្រៈពេញតួ", () {
                    Get.find<AppState>().selectedContent.value = 2;
                  }),
                ],
              )),
        ),
      ],
    );
  }
}
