import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class KTryAgain extends StatefulWidget {
  final bool showOverlay;
  final int numStars;
  final VoidCallback onClose;
  final drawImage;

  const KTryAgain({
    super.key,
    required this.drawImage,
    required this.showOverlay,
    required this.numStars,
    required this.onClose,
  });

  @override
  KTryAgainState createState() => KTryAgainState();
}

class KTryAgainState extends State<KTryAgain> {
  double wSmallStar = 48;
  double wBigStar = 64;

  AudioPlayer? audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer?.play(AssetSource('assets/sounds/gameover.mp3'));
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showOverlay) {
      return const SizedBox.shrink();
    }
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

    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/tick.json', width: 100),
            const SizedBox(height: 20),
            Text(
              "try_again".tr,
              style: TextStyle(
                  color: Colors.white, fontFamily: "Sr", fontSize: 28),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/ui/ui_sq_box.svg',
                    width: 200,
                  ),
                  FittedBox(
                    child: widget.drawImage,
                    fit: BoxFit.contain,
                  )
                ],
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: widget.numStars == 0
                    ? [ssD, sbD, ssD]
                    : (widget.numStars == 1
                        ? [ssE, sbD, ssD]
                        : (widget.numStars == 2
                            ? [ssE, sbE, ssD]
                            : [ssE, sbE, ssE]))),
            const SizedBox(height: 20),
            KButton(
              "close".tr,
              widget.onClose,
            ),
          ],
        ),
      ),
    );
  }
}
