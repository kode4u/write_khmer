import 'package:dictionary/screens/main/category_content.dart';
import 'package:dictionary/screens/main/level_content.dart';
import 'package:dictionary/screens/main/main_content.dart';
import 'package:dictionary/widgets/k_icon_button.dart';
import 'package:dictionary/widgets/k_score.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../states/app_state.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    MainContent(), // Your first page's content
    CategoryContent(),
    LevelContent(),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = Get.find<AppState>().selectedContent.value;
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
            Positioned(
              top: 200,
              left: 10,
              right: 10,
              child: Center(
                child: Text(
                  'app_name'.tr,
                  style: TextStyle(
                      fontSize: 32, color: Colors.white, fontFamily: 'Muol'),
                ),
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
