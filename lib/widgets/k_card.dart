import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KCard extends StatelessWidget{

  var listColor;
  var svgPath;
  var title;


  KCard({super.key, required this.title, required this.svgPath, required this.listColor});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
                alignment: Alignment.center,
                height: 116,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: listColor,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Transform(
                        transform: Matrix4.identity().scaled(5.0)
                          ..translate(0.0, -27.0),
                        child: SvgPicture.asset(
                          svgPath,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.2),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            svgPath,
                            width: 28,
                            height: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Transform(
                        transform: Matrix4.identity()..translate(0.0, 2),
                        child: SvgPicture.asset('assets/images/ic_button_shape.svg'),
                      ),
                    ),
                  ],
                )),
          ),
        );
  }
}