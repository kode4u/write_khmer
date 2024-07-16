import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class KTextEn extends StatelessWidget {
  String text;
  double size;
  KTextEn(this.text, {this.size = 32, super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'ChangaOne',
        fontSize: size,
        color: Colors
            .white, // This will not be visible because ShaderMask applies the gradient
        shadows: [
          Shadow(
            offset: Offset(1, 1), // Shadow offset
            blurRadius: 4.0, // Shadow blur radius
            color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
