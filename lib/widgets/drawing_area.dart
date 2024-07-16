import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dictionary/widgets/k_dark_overlay.dart';
import 'dart:ui' as ui;

import 'grid_widget.dart';

class DrawingArea extends StatefulWidget {
  final double width;
  final double height;
  String text;
  DrawingArea(
      {super.key,
      required this.text,
      required this.width,
      required this.height});
  @override
  _DrawingAreaState createState() => _DrawingAreaState();
}

class _DrawingAreaState extends State<DrawingArea> {
  List<Offset?> points = [];

  bool showText = true;
  bool showGrid = true;
  bool showDrawing = true;
  final GlobalKey _key = GlobalKey();
  final GlobalKey _textKey = GlobalKey();
  var correctness = 0.0;
  ui.Image? capturedImage;
  ui.Image? capturedTextImage;
  var _showOverlay = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  void playLevelup() async {
    await _audioPlayer.play(AssetSource('sounds/levelup.mp3'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  !showGrid
                      ? Container()
                      : GridWidget(
                          width: widget.width,
                          height: widget.height,
                          rows: 12,
                          columns: 3,
                          gridColor: Colors.black87),
                  !showText
                      ? Container()
                      : SizedBox(
                          width: 300,
                          height: 300,
                          child: RepaintBoundary(
                            key: _textKey,
                            child: CustomPaint(
                              painter: TextPainterWidget(widget.text),
                              size: const Size(300, 300),
                            ),
                          ),
                        ),
                  !showDrawing
                      ? Container()
                      : SizedBox(
                          width: 300,
                          height: 300,
                          child: RepaintBoundary(
                            key: _key,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                setState(() {
                                  final RenderBox renderBox =
                                      _key.currentContext!.findRenderObject()
                                          as RenderBox;
                                  points.add(renderBox
                                      .globalToLocal(details.globalPosition));
                                });
                              },
                              onPanEnd: (details) async {
                                points.add(
                                    null); // Add a null point to indicate the end of a line

                                //check
                                await _captureDrawing();
                                if (capturedTextImage == null) {
                                  await _captureTextImage();
                                }
                                _calculateCoveragePercentage(
                                    capturedImage!, capturedTextImage!);
                              },
                              child: CustomPaint(
                                painter: DrawingPainter(points: points),
                                size: const Size(300, 300),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        correctness = 0.0;
                        points.clear();
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/ui/ui_wrong.svg',
                      width: 64,
                    ),
                  ),
                ),
              ],
            ),
            Text("Correctness: ${correctness.toStringAsFixed(2)}"),
            // const SizedBox(
            //   height: 8,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CupertinoCheckbox(
            //         value: showText,
            //         onChanged: (v) {
            //           setState(() {
            //             showText = v!;
            //           });
            //         }),
            //     const Text('អក្សរ'),
            //     CupertinoCheckbox(
            //         value: showGrid,
            //         onChanged: (v) {
            //           setState(() {
            //             showGrid = v!;
            //           });
            //         }),
            //     const Text('ក្រឡា'),
            //     CupertinoCheckbox(
            //         value: showDrawing,
            //         onChanged: (v) {
            //           setState(() {
            //             showDrawing = v!;
            //           });
            //         }),
            //     const Text('គំនូស')
            //   ],
            // )
          ],
        ),
        DarkOverlay(
            showOverlay: _showOverlay,
            numStars: 3,
            onClose: () {
              setState(() {
                _showOverlay = false;
              });
            }),
      ],
    );
  }

  Offset _constrainToBounds(Offset position) {
    double x = position.dx.clamp(0.0, widget.width);
    double y = position.dy.clamp(0.0, widget.height);
    return Offset(x, y);
  }

  Future<double> _calculateCoveragePercentage(
      ui.Image img1, ui.Image img2) async {
    final int width = img2.width;
    final int height = img2.height;

    if (img1.width != width || img1.height != height) {
      throw Exception('Images must be of the same size.');
    }

    final ByteData byteData1 =
        (await img1.toByteData(format: ui.ImageByteFormat.rawRgba))!;
    final ByteData byteData2 =
        (await img2.toByteData(format: ui.ImageByteFormat.rawRgba))!;

    final Uint8List buffer1 = byteData1.buffer.asUint8List();
    final Uint8List buffer2 = byteData2.buffer.asUint8List();

    final int length = buffer2.lengthInBytes;
    int coveredPixels = 0;
    int totalPixels = 0;

    for (int i = 0; i < length; i += 4) {
      final int alphaImg2 = buffer2[i + 3];

      if (alphaImg2 > 0) {
        totalPixels++;
        final int alphaImg1 = buffer1[i + 3];
        if (alphaImg1 > 0) {
          coveredPixels++;
        }
      }
    }

    final double coverageRatio =
        totalPixels > 0 ? coveredPixels / totalPixels : 0.0;
    print('cover ratio $coverageRatio');
    setState(() {
      correctness = coverageRatio;
    });
    if (correctness >= 0.50) {
      setState(() {
        playLevelup();
        _showOverlay = true;
      });
    } else if (correctness >= 0.60) {
      setState(() {
        playLevelup();
        _showOverlay = true;
      });
    } else if (correctness >= 0.80) {
      setState(() {
        playLevelup();
        _showOverlay = true;
      });
    }
    return coverageRatio * 100;
  }

  Future<void> _captureDrawing() async {
    final RenderRepaintBoundary boundary =
        _key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 1.0);
    setState(() {
      capturedImage = image;
    });
  }

  Future<void> _captureTextImage() async {
    final RenderRepaintBoundary textBoundary =
        _textKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    final ui.Image textImage = await textBoundary.toImage(pixelRatio: 1.0);

    setState(() {
      capturedTextImage = textImage;
    });
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0;

    canvas.clipRect(
        Rect.fromLTWH(0, 0, size.width, size.height)); // Clip the canvas

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ImagePainter extends CustomPainter {
  final ui.Image image;

  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the image on the canvas
    canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TextPainterWidget extends CustomPainter {
  final text;
  TextPainterWidget(this.text);
  @override
  void paint(Canvas canvas, Size size) {
    final TextSpan textSpan = TextSpan(
      text: text,
      style: const TextStyle(
          color: Colors.white, fontSize: 300, fontFamily: 'Thin'),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    final Offset offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
