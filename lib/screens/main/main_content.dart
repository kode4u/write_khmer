import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../states/app_state.dart';
import '../../widgets/k_icon_button.dart';
import '../../widgets/k_menu_button.dart';
import '../../widgets/k_progress.dart';
import '../../widgets/k_score.dart';

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // Positioned(
        //   top: 50,
        //   left: 20,
        //   child: SvgPicture.asset(
        //     'assets/ui/ui_setting.svg',
        //     width: 64,
        //   ),
        // ),
        Positioned.fill(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 96),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KMenuButton('start'.tr, () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute<void>(
                      //     builder: (BuildContext context) =>
                      //         const KSelectCategoryScreen(),
                      //   ),
                      // );
                      Get.find<AppState>().selectedContent.value = 1;
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KIconButton('assets/ui/ui_ranking.svg', () {}),
                  const SizedBox(
                    width: 12,
                  ),
                  KIconButton('assets/ui/ui_setting.svg', () {}),
                ],
              )
            ],
          ),
        ),

        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Center(
            child: Obx(() => KProgress(Get.find<AppState>().progress.value)),
          ),
        ),
      ],
    );
  }
}
