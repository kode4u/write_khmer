import 'package:dictionary/widgets/k_user_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../states/app_state.dart';
import '../../widgets/k_icon_button.dart';
import '../../widgets/k_menu_button.dart';
import '../../widgets/k_progress.dart';
import 'main_screen.dart';

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  bool showUserInput = false;

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
                      //if user havent input username show dialog
                      if (Get.find<AppState>().user.isEmpty) {
                        setState(() {
                          showUserInput = true;
                        });
                      } else {
                        //else show new screen
                        Get.find<AppState>().switchScreen(Screen.category);
                      }
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
              ),
            ],
          ),
        ),
        if (showUserInput)
          KUserInput(onClose: () {
            setState(() {
              showUserInput = false;
            });
          }),
      ],
    );
  }
}
