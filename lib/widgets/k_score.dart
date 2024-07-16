import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KScore extends StatelessWidget {
  var text;
  KScore(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/ui/ui2_score_holder.svg',
          height: 60,
        ),
        Positioned(
          top: 10,
          left: 80,
          right: 20,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'ChangaOne',
                fontSize: 28,
                color: Colors
                    .white, // This will not be visible because ShaderMask applies the gradient
                shadows: [
                  Shadow(
                    offset: Offset(1, 1), // Shadow offset
                    blurRadius: 4.0, // Shadow blur radius
                    color: Colors.grey
                        .withOpacity(0.5), // Shadow color with opacity
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
