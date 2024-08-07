import 'package:dictionary/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../services/api.dart';
import '../../states/app_state.dart';
import '../../widgets/k_container.dart';

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

  List data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    List item = await queryLeaderboard();
    setState(() => data = item);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin:
                  const EdgeInsets.only(top: 60, bottom: 8, right: 8, left: 8),
              width: double.infinity,
              height: height - 180,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // SvgPicture.asset(
                  //   'assets/ui/ui_sq_box.svg',
                  //   width: width,
                  // ),
                  SizedBox(
                    width: double.infinity,
                    height: height - 240,
                  ),
                  const Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: KContainer()),

                  Positioned(
                    left: 0,
                    right: 0,
                    top: -18,
                    child: KButton(
                      'leaderboard'.tr,
                      () {
                        Get.find<AppState>().back();
                      },
                      height: 40,
                      size: 20,
                      marginTop: 4,
                    ),
                  ),
                  // FittedBox(
                  //   child: widget.drawImage,
                  //   fit: BoxFit.contain,
                  // )

                  data.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 10,
                          ),
                        )
                      : Positioned(
                          top: 25,
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: data
                                  .map(
                                    (e) => RankItem(e.rank, e.username,
                                        e.totalscore, e.star),
                                  )
                                  .toList(),
                            ),
                          ))
                ],
              ),
            ),
            KButton(
              'close'.tr,
              () {
                Get.find<AppState>().back();
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

  Widget RankItem(int rank, String name, int score, int star) {
    List<Widget> stars = [];
    if (star == 0) {
      stars = [
        SvgPicture.asset('assets/ui/ui_star_dis.svg', width: 24),
        SvgPicture.asset('assets/ui/ui_star_dis.svg', width: 24),
        SvgPicture.asset('assets/ui/ui_star_dis.svg', width: 24),
      ];
    }
    if (star == 1) {
      stars = [
        SvgPicture.asset('assets/ui/ui_star_en.svg', width: 24),
        SvgPicture.asset('assets/ui/ui_star_dis.svg', width: 24),
        SvgPicture.asset('assets/ui/ui_star_dis.svg', width: 24),
      ];
    }
    if (star == 2) {
      stars = [
        SvgPicture.asset('assets/ui/ui_star_en.svg', width: 24),
        SvgPicture.asset('assets/ui/ui_star_en.svg', width: 24),
        SvgPicture.asset('assets/ui/ui_star_dis.svg', width: 24),
      ];
    }
    if (star == 3) {
      stars = [
        SvgPicture.asset('assets/ui/ui_star_en.svg', width: 24),
        SvgPicture.asset('assets/ui/ui_star_en.svg', width: 24),
        SvgPicture.asset('assets/ui/ui_star_en.svg', width: 24),
      ];
    }
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 8, top: 8),
      padding: const EdgeInsets.all(0),
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
                      left: 19,
                      top: 11,
                      child: Text(
                        '$rank',
                        style: const TextStyle(
                          fontFamily: 'ChangaOne',
                          color: Colors.white,
                          fontSize: 16,
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
                      style: const TextStyle(
                        fontFamily: 'ChangaOne',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                  fontFamily: 'ChangaOne', color: Colors.white, fontSize: 16),
            ),
          ),
          const Spacer(),
          Row(
            children: stars,
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            width: 64,
            child: Text(
              '$score',
              style: const TextStyle(
                  fontFamily: 'ChangaOne', color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
