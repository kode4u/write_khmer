import 'package:flutter/material.dart';

class KGradientOutlineText extends StatelessWidget {
  final String text;
  final double fontSize;
  final List<Color> gradientColors;
  final double outlineWidth;
  final Color outlineColor;
  final Color shadowColor;
  bool enFont = false;

  KGradientOutlineText(
    this.text, {
    super.key,
    this.fontSize = 40.0,
    this.gradientColors = const [Colors.yellow, Colors.amber, Colors.orange],
    this.outlineWidth = 3.0,
    this.outlineColor = Colors.white,
    this.shadowColor = Colors.black,
    this.enFont = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: enFont ? 'ChangaOne' : 'Muol', // Use your desired font
      fontSize: fontSize,
      color: Colors.white, // Color is ignored by ShaderMask
    );
    // Create a TextPainter to measure the text
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();

    final size = textPainter.size;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Outline text
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Muol', // Use your desired font
                fontSize: fontSize,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = outlineWidth
                  ..color = Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0.5,
          top: 0.5,
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            child: Text(
              text,
              style: TextStyle(
                fontFamily:
                    enFont ? 'ChangaOne' : 'Muol', // Use your desired font
                fontSize: fontSize,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = outlineWidth
                  ..color = Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          left: 1,
          top: 1,
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            child: Text(
              text,
              style: TextStyle(
                fontFamily:
                    enFont ? 'ChangaOne' : 'Muol', // Use your desired font
                fontSize: fontSize,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = outlineWidth
                  ..color = Colors.white,
              ),
            ),
          ),
        ),

        // Gradient fill text
        // Gradient fill text
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(
              Rect.fromLTWH(
                -size.width * 0.1, // Added padding to the left
                -size.height * 0.1, // Added padding to the top
                size.width * 1.2, // Increased width to cover text completely
                size.height * 1.2, // Increased height to cover text completely
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            child: Text(
              text,
              style: TextStyle(
                fontFamily:
                    enFont ? 'ChangaOne' : 'Muol', // Use your desired font
                fontSize: fontSize,
                color: Colors.white, // This color will be ignored by ShaderMask
              ),
            ),
          ),
        ),
      ],
    );
  }
}
