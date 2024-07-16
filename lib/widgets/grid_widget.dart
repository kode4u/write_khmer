import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final int rows;
  final int columns;
  final Color gridColor;
  final double thickRowThickness;
  final double stroke;

  GridPainter({
    required this.rows,
    required this.columns,
    required this.gridColor,
    this.thickRowThickness = 0.5, // Thickness for thicker rows
    this.stroke = 0.5, // Thickness for rows
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the width and height of each cell
    double cellWidth = size.width / columns;
    double cellHeight = size.height / rows;

    Paint paint = Paint()
      ..color = gridColor
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke;

    // Draw horizontal grid lines
    for (int i = 0; i <= rows; i++) {
      double y = i * cellHeight;
      if (i % 4 == 0) {
        paint.strokeWidth = thickRowThickness; // Make every fourth row thicker
      } else {
        paint.strokeWidth = stroke; // Reset to normal thickness for other rows
      }
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw vertical grid lines
    for (int i = 0; i <= columns; i++) {
      double x = i * cellWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
// Grid Widget
// Grid Widget
class GridWidget extends StatelessWidget {
  final int rows;
  final int columns;
  final Color gridColor;
  final double thickRowThickness;
  final double stroke;
  final double width;
  final double height;

  const GridWidget({super.key, 
    required this.rows,
    required this.columns,
    required this.gridColor,
    this.thickRowThickness = 0.5,
    this.stroke = 0.2,
    this.width = 256,
    this.height = 256,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,height: height,
      child: CustomPaint(
        painter: GridPainter(
          rows: rows,
          columns: columns,
          gridColor: gridColor,
          thickRowThickness: thickRowThickness,
          stroke: stroke,
        ),
        child: Container(), // This is needed to make CustomPaint widget work
      ),
    );
  }
}
