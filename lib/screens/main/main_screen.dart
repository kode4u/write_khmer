import 'package:dictionary/screens/select_category/select_category_screen.dart';
import 'package:dictionary/widgets/k_icon_button.dart';
import 'package:dictionary/widgets/k_score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dictionary/widgets/k_button.dart';
import 'package:dictionary/widgets/k_progress.dart';
import 'package:dictionary/widgets/k_text.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../states/app_state.dart';
import '../../widgets/k_menu_button.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
            top: 240,
            left: 10,
            right: 10,
            child: Center(
              child: Lottie.asset(
                'assets/animated/bird.json',
                width: width / 3,
              ),
            ),
          ),
          const Positioned(
            top: 200,
            left: 10,
            right: 10,
            child: Center(
              child: Text(
                'រៀនសរសេរ​',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const KSelectCategoryScreen(),
                          ),
                        );
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
      ),
    );
  }
}
