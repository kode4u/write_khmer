import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../states/app_state.dart';

class LevelContent extends StatefulWidget {
  const LevelContent({Key? key}) : super(key: key);

  @override
  _LevelContentState createState() => _LevelContentState();
}

class _LevelContentState extends State<LevelContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<int> _delays = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Initialize delays for staggering animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final itemCount = Get.find<AppState>().data.length;
      setState(() {
        _delays.addAll(List.generate(itemCount, (index) => index * 100));
      });
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
              itemCount: app.data.length, // Total number of items in the grid
              itemBuilder: (context, index) {
                // Delay based on the item index for staggered animation
                Future.delayed(Duration(milliseconds: _delays[index]), () {
                  if (mounted) {
                    setState(() {}); // Trigger a rebuild after delay
                  }
                });

                double cardWidth = (width - 24) / 3;
                double wSmallStar = (cardWidth - 64) / 3;
                double wBigStar = (cardWidth - 32) / 3;
                var ssE = SvgPicture.asset(
                  'assets/ui/ui_star_en.svg',
                  width: wSmallStar,
                );
                var ssD = SvgPicture.asset(
                  'assets/ui/ui_star_dis.svg',
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
                        offset: Offset(0, 100 * (1 - animationValue)),
                        child: GestureDetector(
                          onTap: () {
                            app.selectedContent.value = 3;
                            app.currentIndex.value = index;
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
                                  app.data[index]['c'].toString(),
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
                                  children: (app.data[app.currentIndex.value]
                                              ['star'] ==
                                          0
                                      ? [ssD, sbD, ssD]
                                      : (app.data[app.currentIndex.value]
                                                  ['star'] ==
                                              1
                                          ? [ssE, sbD, ssD]
                                          : (app.data[app.currentIndex.value]
                                                      ['star'] ==
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
