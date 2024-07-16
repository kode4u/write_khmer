import 'package:dictionary/screens/kor_khor/grid_screen.dart';
import 'package:dictionary/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dictionary/widgets/k_progress.dart';
import 'package:dictionary/widgets/k_text.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../states/app_state.dart';
import '../../widgets/k_icon_button.dart';

class KSelectCategoryScreen extends StatelessWidget {
  const KSelectCategoryScreen({super.key});

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
          bottom: 50,
          right: 10,
          child: Center(
            child: Lottie.asset('assets/bg/kids.json', width: width / 2.3),
          ),
        ),
        Positioned(
          top: 70,
          left: 20,
          child: KIconButton(
            'assets/ui/ui_previous.svg',
            () {
              Navigator.pop(context);
            },
            height: 48,
          ),
        ),
        const Positioned(
          top: 50,
          left: 10,
          right: 10,
          child: Center(
            child: KText(
              "10",
            ),
          ),
        ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => GridScreen(),
                      ),
                    );
                  }),
                  KButton("លេខ", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => GridScreen(),
                      ),
                    );
                  }),
                  KButton("ជើងព្យញ្ជនៈ", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => GridScreen(),
                      ),
                    );
                  }),
                  KButton("ស្រៈ", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => GridScreen(),
                      ),
                    );
                  }),
                  KButton("ស្រៈពេញតួ", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => GridScreen(),
                      ),
                    );
                  }),
                ],
              )),
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
    ));
  }
}
