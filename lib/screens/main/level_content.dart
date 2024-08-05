// ignore_for_file: unused_local_variable

import 'package:dictionary/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../states/app_state.dart';

class LevelContent extends StatefulWidget {
  const LevelContent({super.key});

  @override
  LevelContentState createState() => LevelContentState();
}

class LevelContentState extends State<LevelContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    AppState app = Get.find<AppState>();

    return Stack(
      children: [
        Positioned(
          top: 220,
          left: 10,
          right: 10,
          bottom: 10,
          child: Obx(
            () => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of items per row
                crossAxisSpacing: 4.0, // Horizontal spacing between items
                mainAxisSpacing: 24.0, // Vertical spacing between items
              ),
              itemCount: app.allData[app.currentKey.value]
                  .length, // Total number of items in the grid
              itemBuilder: (context, index) {
                double cardWidth = (width - 24) / 3;
                double wSmallStar = (cardWidth - 64) / 3;
                double wBigStar = (cardWidth - 32) / 3;
                var ssD = SvgPicture.asset(
                  'assets/ui/ui_star_dis.svg',
                  width: wSmallStar,
                );
                var ssE = SvgPicture.asset(
                  'assets/ui/ui_star_en.svg',
                  width: wSmallStar,
                );
                var sbE = SvgPicture.asset(
                  'assets/ui/ui_star_en.svg',
                  width: wBigStar,
                );
                var sbD = SvgPicture.asset(
                  'assets/ui/ui_star_dis.svg',
                  width: wBigStar,
                );

                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final animationValue = _controller.value;
                    return Opacity(
                      opacity: animationValue,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - animationValue)),
                        child: GestureDetector(
                          onTap: () {
                            Get.find<AppState>().selectedIndex.value = index;
                            app.switchScreen(Screen.draw);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                child: SvgPicture.asset(
                                  'assets/ui/ui_bubble.svg',
                                  width: cardWidth,
                                ),
                              ),
                              Positioned(
                                top: 22,
                                child: Text(
                                  app.allData[app.currentKey.value][index]['c']
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sr',
                                    fontSize: 48,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 2,
                                left: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: (app.allData[app.currentKey.value]
                                              [index]['star'] ==
                                          0
                                      ? [ssD, sbD, ssD]
                                      : (app.allData[app.currentKey.value]
                                                  [index]['star'] ==
                                              1
                                          ? [ssE, sbD, ssD]
                                          : (app.allData[app.currentKey.value]
                                                      [index]['star'] ==
                                                  2
                                              ? [ssE, sbE, ssD]
                                              : [ssE, sbE, ssE]))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
