import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class AnimatedSvg extends StatefulWidget {
  final String filename;
  const AnimatedSvg({super.key, required this.filename});

  @override
  State<AnimatedSvg> createState() => _AnimatedSvgState();
}

class _AnimatedSvgState extends State<AnimatedSvg> {
  String svgData = """
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  svg {
    width: 100%; /* Occupy full width of its container */
    height: auto; /* Maintain aspect ratio */
  }
</style>
</head>
<body>
 
</body>
</html>
      """;

  late WebViewController controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(svgData);

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      controller.loadHtmlString(svgData);
    });

    loadAsset();
  }

  Future<void> loadAsset() async {
    final content = await rootBundle.loadString(widget.filename);
    svgData = """
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  svg {
    width: 100%; /* Occupy full width of its container */
    height: auto; /* Maintain aspect ratio */
  }
</style>
</head>
<body>
  $content
</body>
</html>
      """;
    controller.loadHtmlString(svgData);
  }

  @override
  void dispose() {
    _timer.cancel();
    controller.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
