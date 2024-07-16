import 'package:dictionary/widgets/k_text.dart';
import 'package:dictionary/widgets/k_text_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../states/app_state.dart';

class KProgress extends StatelessWidget {
  int progress = 33;

  KProgress(this.progress, {super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: [
          Positioned(
              child: SvgPicture.asset(
            'assets/ui/ui_progress_bg.svg',
            width: width,
            height: 30,
          )),
          Positioned(
            child: SizedBox(
              width: width * progress / 100,
              child: SvgPicture.asset(
                'assets/ui/ui_progress_fg.svg',
                width: width * progress / 100,
                height: 30,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 2,
            left: 0,
            right: 0,
            child: KTextEn(
              "$progress%",
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
