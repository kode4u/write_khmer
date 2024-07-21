import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../states/app_state.dart';
import '../../widgets/k_gradient_outline_text.dart';
import '../../widgets/k_icon_button.dart';
import '../../widgets/k_menu_button.dart';
import 'main_screen.dart';

class LanguageContent extends StatelessWidget {
  const LanguageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 160,
          left: 10,
          right: 10,
          child: Center(
            child: KGradientOutlineText(
              "Language",
              enFont: true,
            ),
          ),
        ),

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
                      Get.find<AppState>().switchScreen(Screen.category);
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
                  KIconButton('assets/ui/ui_ranking.svg', () {
                    Get.find<AppState>().switchScreen(Screen.leaderboard);
                  }),
                  const SizedBox(
                    width: 12,
                  ),
                  KIconButton('assets/ui/ui_setting.svg', () {
                    Get.find<AppState>().switchScreen(Screen.setting);
                  }),
                ],
              )
            ],
          ),
        ),

        // Positioned(
        //   bottom: 10,
        //   left: 10,
        //   right: 10,
        //   child: Center(
        //     child: Obx(() => KProgress(Get.find<AppState>().progress.value)),
        //   ),
        // ),
      ],
    );
  }
}
