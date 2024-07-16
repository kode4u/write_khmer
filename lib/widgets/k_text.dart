import 'package:flutter/material.dart';
import 'package:kode4u/utils/k_utils.dart';

class KText extends StatelessWidget {
  final String text;

  const KText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [Colors.white, Colors.white], // Colors for the gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          fontFamily: KUtil.isKh() ? 'Sr' : 'ChangaOne',
          fontSize: 32,
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
      ),
    );
  }
}
