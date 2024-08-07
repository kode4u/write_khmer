
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'k_button_2.dart';

class DarkOverlay extends StatefulWidget {
  final bool showOverlay;
  final int numStars;
  final VoidCallback onClose;
  final drawImage;

  const DarkOverlay({
    super.key,
    required this.drawImage,
    required this.showOverlay,
    required this.numStars,
    required this.onClose,
  });

  @override
  DarkOverlayState createState() => DarkOverlayState();
}

class DarkOverlayState extends State<DarkOverlay> {
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
        color: Colors.black.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "អបអរសាទរ",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Sr", fontSize: 28),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
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
            KButton2(
              "close".tr,
              marginTop: 10,
              width: 96,
              height: 48,
              size: 20,
              widget.onClose,
            ),
          ],
        ),
      ),
    );
  }
}
