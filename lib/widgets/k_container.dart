import 'package:flutter/material.dart';

class KContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double borderWidth = 4;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFFFDE049), Color(0xFFFDE049)],
                ),
                borderRadius:
                    BorderRadius.circular(16), // Adjust as per your needs
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFA6B49),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset:
                        Offset(0, 5), // Changes the shadow position rightwards
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.all(borderWidth),
              width: width - borderWidth * 2,
              height: height - borderWidth * 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFFFA6B49), Color(0xFFFEB749)],
                ),
                borderRadius:
                    BorderRadius.circular(16), // Adjust as per your needs
                boxShadow: [
                  // BoxShadow(
                  //   color: Color(0xFFFA6B49),
                  //   spreadRadius: 1,
                  //   blurRadius: 0,
                  //   offset:
                  //       Offset(0, 3), // Changes the shadow position rightwards
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
