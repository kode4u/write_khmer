import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../states/app_state.dart';
import '../../widgets/k_icon_button.dart';
import '../../widgets/k_menu_button.dart';
import '../../widgets/k_progress.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
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
                  KIconButton('assets/ui/ui_ranking.svg', () {
                    Get.find<AppState>().lastSelectedIndex =
                        Get.find<AppState>().selectedContent;
                    Get.find<AppState>().selectedContent.value = 4;
                  }),
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
