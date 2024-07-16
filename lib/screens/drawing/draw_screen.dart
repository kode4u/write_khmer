import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary/states/app_state.dart';
import 'package:dictionary/widgets/drawing_area.dart';
import 'package:flutter/material.dart';
import 'package:dictionary/widgets/k_icon_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/animated_svg.dart';
import '../../widgets/k_style_container.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({super.key});

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg/mountain.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 128,
                width: 128,
                child: AnimatedSvg(),
              ),
              KStyleContainer(
                  title: 'សរសេរ',
                  svgPath: 'assets/images/ic_magic_triangle.svg',
                  listColor: [Colors.purple.shade500, Colors.purple.shade800],
                  child: DrawingArea(
                    text: 'ខ',
                    width: width - 80,
                    height: width - 80,
                  )),
              // Container(
              //   color: Colors.blue,height:128, width: 128,
              //   child: AnimatedSvg(),),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          KIconButton('assets/ui/ui_play.svg', () {
            AudioPlayer p = AudioPlayer();
            p.play(AssetSource('sounds/ខ.mp3'));
          }),
        ],
      ),
    );
  }
}
