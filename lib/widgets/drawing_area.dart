import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'grid_widget.dart';
import 'k_dark_overlay.dart';
import 'k_icon_button.dart';

class DrawingArea extends StatefulWidget {
  DrawingArea({super.key});

  @override
  DrawingAreaState createState() => DrawingAreaState();
}

class DrawingAreaState extends State<DrawingArea> {
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
  bool isProcessing = false;
  int star = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16;
    AppState app = Get.find<AppState>();
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              height: width,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SvgPicture.asset('assets/ui/ui_sq_box.svg'),
                  ),
                  if (showGrid)
                    GridWidget(
                        width: width,
                        height: width,
                        rows: 12,
                        columns: 3,
                        gridColor: Colors.black87),
                  if (showText)
                    SizedBox(
                      width: width,
                      height: width,
                      child: RepaintBoundary(
                        key: _textKey,
                        child: Obx(
                          () => CustomPaint(
                            painter: TextPainterWidget(Get.find<AppState>()
                                .data[Get.find<AppState>().currentIndex.value]
                                    ['c']
                                .toString()),
                            size: Size(width, width),
                          ),
                        ),
                      ),
                    ),
                  if (showDrawing)
                    SizedBox(
                      width: width,
                      height: width,
                      child: RepaintBoundary(
                        key: _key,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            _onPanUpdate(details);
                          },
                          onPanEnd: (details) async {
                            _onPanEnd();
                          },
                          child: CustomPaint(
                            painter: DrawingPainter(points: points),
                            size: Size(width, width),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset('assets/ui/ui_place_holder.svg'),
                Container(
                  margin: const EdgeInsets.only(left: 5, top: 12, right: 5),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        app.currentIndex.value == 0
                            ? const SizedBox(
                                width: 28,
                                height: 28,
                              )
                            : KIconButton('assets/ui/ui_previous.svg', () {
                                if (app.currentIndex > 0) {
                                  app.currentIndex--;
                                }
                              }, height: 32),
                        const SizedBox(width: 30),
                        KIconButton(
                          'assets/ui/ui_wrong.svg',
                          () {
                            setState(() {
                              correctness = 0.0;
                              points.clear();
                            });
                          },
                          height: 40,
                        ),
                        const SizedBox(width: 30),
                        app.currentIndex.value == app.data.length - 1
                            ? const SizedBox(
                                width: 28,
                                height: 28,
                              )
                            : KIconButton('assets/ui/ui_next.svg', () {
                                if (app.currentIndex < app.data.length - 1) {
                                  app.currentIndex++;
                                }
                              }, height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text("Correctness: ${correctness.toStringAsFixed(2)}"),
          ],
        ),
        DarkOverlay(
            showOverlay: _showOverlay,
            drawImage: CustomPaint(
              painter: DrawingPainter(points: points),
              size: Size(width, width),
            ),
            numStars: star,
            onClose: () {
              setState(() {
                _showOverlay = false;
                points.clear();
              });
            }),
      ],
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      points.add(renderBox.globalToLocal(details.globalPosition));
    });
  }

  void _onPanEnd() async {
    points.add(null); // End of line
    await _captureDrawing();
    if (capturedTextImage == null) {
      await _captureTextImage();
    }
    _calculateCoveragePercentage(capturedImage!, capturedTextImage!);
  }

  Future<void> _captureDrawing() async {
    final RenderRepaintBoundary boundary =
        _key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 1.0);
    capturedImage = image;
  }

  Future<void> _captureTextImage() async {
    final RenderRepaintBoundary textBoundary =
        _textKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final ui.Image textImage = await textBoundary.toImage(pixelRatio: 1.0);
    capturedTextImage = textImage;
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

    int coveredPixels = 0;
    int totalPixels = 0;

    int totalDrawPixel = countPixel(buffer1);

    for (int i = 0; i < buffer2.lengthInBytes; i += 4) {
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
    print(
        'over cover ratio drawPixel $totalDrawPixel: ${3 * totalPixels} $coveredPixels - $totalPixels : ${totalDrawPixel > 3 * totalPixels}');
    setState(() {
      correctness = coverageRatio;
    });

    //if
    if (correctness >= 0.80) {
      star = 3;
    } else if (correctness >= 0.70) {
      star = 2;
    } else if (correctness >= 0.60) {
      star = 1;
    }

//if draw pixel is too much star = 0
    if (totalDrawPixel > 3 * totalPixels) {
      star = 0;
      correctness = 0.59;
    }

    if (correctness >= 0.6) {
      _playLevelUp();
      setState(() {
        _showOverlay = true;
      });
    }
    return coverageRatio * 100;
  }

  Future<void> _playLevelUp() async {
    await _audioPlayer.play(AssetSource('sounds/levelup.mp3'));
  }

  int countPixel(Uint8List buffer) {
    int nonTransparentPixels = 0;
    for (int i = 0; i < buffer.lengthInBytes; i += 4) {
      final int alpha = buffer[i + 3];
      if (alpha > 0) {
        nonTransparentPixels++;
      }
    }
    return nonTransparentPixels;
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
    canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TextPainterWidget extends CustomPainter {
  final String text;

  TextPainterWidget(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    final TextSpan textSpan = TextSpan(
      text: text,
      style: const TextStyle(
          color: Colors.white, fontSize: 300, fontFamily: 'Thin'),
    );

    final TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final Offset offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
