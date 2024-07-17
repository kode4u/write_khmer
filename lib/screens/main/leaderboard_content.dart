import 'dart:ui';

import 'package:dictionary/widgets/k_button.dart';
import 'package:dictionary/widgets/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../states/app_state.dart';

class LeaderboardContent extends StatefulWidget {
  const LeaderboardContent({
    super.key,
  });

  @override
  LeaderboardContentState createState() => LeaderboardContentState();
}

class LeaderboardContentState extends State<LeaderboardContent> {
  double wSmallStar = 48;
  double wBigStar = 64;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    'assets/ui/ui_leaderboard.svg',
                    width: width,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: -12,
                    child: KButton('', () {}),
                    height: 64,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: -6,
                    child: KText('rank'.tr, size: 24),
                  ),
                  // FittedBox(
                  //   child: widget.drawImage,
                  //   fit: BoxFit.contain,
                  // )

                  Positioned(
                      top: 25,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RankItem(1, "MUTITA", 120),
                            RankItem(2, "TIMA", 110),
                            RankItem(3, "PAOPAO", 100),
                            RankItem(4, "PAOPAO", 100),
                            RankItem(5, "PAOPAO", 100),
                            RankItem(33, "PAOPAO", 100),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            KButton(
              'close'.tr,
              () {
                Get.find<AppState>().selectedContent =
                    Get.find<AppState>().lastSelectedIndex;
              },
              height: 40,
              size: 20,
              marginTop: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget RankItem(int rank, String name, int score) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 8, top: 8),
      padding: EdgeInsets.all(0),
      child: Row(
        children: [
          rank < 4
              ? Stack(
                  children: [
                    Positioned(
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: SvgPicture.asset(
                          'assets/ui/ui_rank.svg',
                        ),
                      ),
                    ),
                    Positioned(
                      left: 17,
                      top: 7,
                      child: Text(
                        '$rank',
                        style: TextStyle(
                          fontFamily: 'ChangaOne',
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    )
                  ],
                )
              : SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Text(
                      '$rank',
                      style: TextStyle(
                        fontFamily: 'ChangaOne',
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
          SizedBox(
            width: 12,
          ),
          Text(
            name,
            style: TextStyle(
                fontFamily: 'ChangaOne', color: Colors.white, fontSize: 24),
          ),
          Spacer(),
          Row(
            children: [
              SvgPicture.asset(
                'assets/ui/ui_star_en.svg',
                width: 24,
              ),
              SvgPicture.asset(
                'assets/ui/ui_star_en.svg',
                width: 24,
              ),
              SvgPicture.asset(
                'assets/ui/ui_star_en.svg',
                width: 24,
              ),
            ],
          ),
          SizedBox(
            width: 8,
          ),
          SizedBox(
            width: 64,
            child: Text(
              '$score',
              style: TextStyle(
                  fontFamily: 'ChangaOne', color: Colors.white, fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
