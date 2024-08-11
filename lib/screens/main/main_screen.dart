import 'package:dictionary/screens/main/category_content.dart';
import 'package:dictionary/screens/main/language_content.dart';
import 'package:dictionary/screens/main/leaderboard_content.dart';
import 'package:dictionary/screens/main/level_content.dart';
import 'package:dictionary/screens/main/main_content.dart';
import 'package:dictionary/screens/main/setting_content.dart';
import 'package:dictionary/screens/main/draw_content.dart';
import 'package:dictionary/widgets/k_score.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kode4u/configs/k_config.dart';
import 'package:kode4u/utils/k_utils.dart';
import 'package:lottie/lottie.dart';

import '../../states/app_state.dart';
import '../../widgets/k_gradient_outline_text.dart';
import '../../widgets/k_icon_button.dart';

class Screen {
  static const String main = 'main';
  static const String category = 'category';
  static const String level = 'level';
  static const String draw = 'draw';
  static const String leaderboard = 'leaderboard';
  static const String setting = 'setting';
  static const String lang = 'lang';
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  String lang = 'en';

  @override
  void initState() {
    super.initState();
    Get.find<AppState>().playBGMusic();
  }

  @override
  void dispose() {
    super.dispose();
    firstTimeOpen();
  }

  void firstTimeOpen() {
    GetStorage g = GetStorage();
    lang = g.read('lang${KConfig.android_package}') ?? 'en';
    if (lang == 'en') {
      Get.find<AppState>().switchScreen(Screen.lang);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Get.find<AppState>().back();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/bg/mountain.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 60,
              left: 10,
              right: 10,
              child: Center(
                child: Obx(() => [Screen.setting, Screen.leaderboard]
                        .contains(Get.find<AppState>().currentScreen.value)
                    ? Container()
                    : Obx(() => GestureDetector(
                        onTap: () {
                          Get.find<AppState>().switchScreen(Screen.leaderboard);
                        },
                        child: KScore(
                            Get.find<AppState>().score.value.toString())))),
              ),
            ),
            Positioned(
              top: 180,
              left: 10,
              right: 10,
              child: Center(
                child: Obx(
                  () => [Screen.draw]
                          .contains(Get.find<AppState>().currentScreen.value)
                      ? Container()
                      : Obx(() => KGradientOutlineText(
                            Get.find<AppState>().user['username'] == null
                                ? ''
                                : "${'welcome'.tr} ${Get.find<AppState>().user['username']}",
                            fontSize: 24,
                          )),
                ),
              ),
            ),
            Obx(
              () => Get.find<AppState>().currentScreen.value == Screen.draw
                  ? Container()
                  : Positioned(
                      top: 120,
                      left: 10,
                      right: 10,
                      child: Center(
                        child: KGradientOutlineText(
                          'app_name'.tr,
                          enFont: KUtil.isEn(),
                        ),
                      ),
                    ),
            ),
            Positioned(
              top: 80,
              left: 20,
              child: Center(
                child: Obx(() =>
                    Get.find<AppState>().currentScreen.value != Screen.main
                        ? KIconButton(
                            'assets/ui/ui_previous.svg',
                            () {
                              Get.find<AppState>().back();
                            },
                            height: 32,
                          )
                        : Container()),
              ),
            ),
            Positioned(
              top: height * 1 / 3,
              left: -width / 3,
              child: Center(
                child: Lottie.asset('assets/animated/tree.json', width: width),
              ),
            ),
            Positioned(
              right: 0,
              top: height - 350,
              child: Center(
                child: Lottie.asset(
                  'assets/animated/sunflower.json',
                  width: width / 3,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 10,
              child: Center(
                  child: Transform.flip(
                flipX: true,
                child: Lottie.asset(
                  'assets/animated/cow.json',
                  width: width / 3,
                ),
              )),
            ),
            Positioned(
              bottom: 50,
              right: 10,
              child: Center(
                child: Lottie.asset(
                  'assets/bg/kids.json',
                  width: width / 2.3,
                ),
              ),
            ),
            Obx(
              () => AnimatedSwitcher(
                duration: const Duration(
                    milliseconds: 300), // Duration of the animation
                child: getPageWidget(Get.find<AppState>().currentScreen.value),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Get.find<AppState>().ads.bannerWidget(),
      ),
    );
  }

  Widget getPageWidget(String name) {
    switch (name) {
      case Screen.main:
        return const MainContent();
      case Screen.category:
        return const CategoryContent();
      case Screen.level:
        return const LevelContent();
      case Screen.setting:
        return const SettingContent();
      case Screen.leaderboard:
        return const LeaderboardContent();
      case Screen.draw:
        return const DrawContent();
      case Screen.lang:
        return const LanguageContent();
      default:
        return const CircularProgressIndicator(); // Or handle the case where pageIndex is out of bounds
    }
  }
}
