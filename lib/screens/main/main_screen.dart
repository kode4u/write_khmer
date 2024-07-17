import 'package:dictionary/screens/main/category_content.dart';
import 'package:dictionary/screens/main/leaderboard_content.dart';
import 'package:dictionary/screens/main/level_content.dart';
import 'package:dictionary/screens/main/main_content.dart';
import 'package:dictionary/widgets/drawing_area.dart';
import 'package:dictionary/widgets/k_gradient_outline_text.dart';
import 'package:dictionary/widgets/k_icon_button.dart';
import 'package:dictionary/widgets/k_score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../states/app_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    const MainContent(), // Your first page's content
    const CategoryContent(),
    const LevelContent(),
    DrawingArea(),
    LeaderboardContent(),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = Get.find<AppState>().selectedContent.value;
    Get.find<AppState>().playBGMusic();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (Get.find<AppState>().selectedContent.value > 0) {
          Get.find<AppState>().selectedContent.value--;
        }
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
                child: Obx(
                    () => KScore(Get.find<AppState>().score.value.toString())),
              ),
            ),
            Obx(
              () => Get.find<AppState>().selectedContent.value == 3
                  ? Container()
                  : Positioned(
                      top: 160,
                      left: 10,
                      right: 10,
                      child: Center(
                        child: KGradientOutlineText(
                          'app_name'.tr,
                        ),
                      ),
                    ),
            ),
            Positioned(
              top: 80,
              left: 20,
              child: Center(
                child: Obx(() => Get.find<AppState>().selectedContent.value != 0
                    ? KIconButton(
                        'assets/ui/ui_previous.svg',
                        () {
                          Get.find<AppState>().selectedContent.value--;
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
                child: _pages[Get.find<AppState>().selectedContent.value],
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            ),
            Get.find<AppState>().selectedContent.value > 0
                ? Positioned(
                    top: 70,
                    left: 20,
                    child: KIconButton(
                      'assets/ui/ui_previous.svg',
                      () {
                        setState(() {
                          Get.find<AppState>().selectedContent.value--;
                        });
                      },
                      height: 48,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
