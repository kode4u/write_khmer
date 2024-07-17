import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KStyleContainer extends StatelessWidget {
  final List<Color> listColor;
  final String svgPath;
  final String title;
  final Widget child;

  const KStyleContainer(
      {super.key,
      required this.child,
      required this.title,
      required this.svgPath,
      required this.listColor});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: listColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Align(alignment: Alignment.center, child: child),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Transform(
                    transform: Matrix4.identity()..translate(0.0, 0),
                    child:
                        SvgPicture.asset('assets/images/ic_button_shape.svg'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
