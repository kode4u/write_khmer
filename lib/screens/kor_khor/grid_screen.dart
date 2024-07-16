import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../drawing/draw_screen.dart';

class GridScreen extends StatelessWidget {
  List data = List.generate(33, (index) => {'text': 'ឡ', 'score': 2});

  GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg/mountain.png',
              fit: BoxFit.cover,
            ),
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of items per row
              crossAxisSpacing: 4.0, // Horizontal spacing between items
              mainAxisSpacing: 24.0, // Vertical spacing between items
            ),
            itemCount: data.length, // Total number of items in the grid
            itemBuilder: (context, index) {
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
              return GestureDetector(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const DrawScreen(),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        child: SvgPicture.asset(
                      'assets/ui/ui_bubble.svg',
                      width: cardWidth,
                    )),
                    Positioned(
                      top:
                          22, // Move the text up by 10 pixels; adjust as needed
                      child: Text(
                        data[index]['text'],
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
                        children: (data[index]['score'] == 0
                            ? [ssD, sbD, ssD]
                            : (data[index]['score'] == 1
                                ? [ssE, sbD, ssD]
                                : (data[index]['score'] == 2
                                    ? [ssE, sbE, ssD]
                                    : [ssE, sbE, ssE]))),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
