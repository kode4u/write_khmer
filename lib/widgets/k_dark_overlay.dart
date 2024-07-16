import 'package:dictionary/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class DarkOverlay extends StatefulWidget {
  final bool showOverlay;
  final int numStars;
  final VoidCallback onClose;

  const DarkOverlay({
    super.key,
    required this.showOverlay,
    required this.numStars,
    required this.onClose,
  });

  @override
  _DarkOverlayState createState() => _DarkOverlayState();
}

class _DarkOverlayState extends State<DarkOverlay> {
  double wSmallStar = 64;
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
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/tick.json', width: 100),
            const SizedBox(height: 20),
            const Text(
              "អបអរសាទរ",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Sr", fontSize: 28),
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
              "Close",
              widget.onClose,
            ),
          ],
        ),
      ),
    );
  }
}
