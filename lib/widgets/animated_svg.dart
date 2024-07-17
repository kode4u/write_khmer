import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnimatedSvg extends StatefulWidget {
  const AnimatedSvg({super.key});

  @override
  State<AnimatedSvg> createState() => _AnimatedSvgState();
}

class _AnimatedSvgState extends State<AnimatedSvg> {
  String svgData = '''
    <html>
    <body>
      <svg id="z12736" class="acjk" version="1.1" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <style>
      <![CDATA[
      @keyframes zk {
        to {
          stroke-dashoffset:0;
        }
      }
      svg.acjk path[clip-path] {
        --t:3s;
        animation:zk var(--t) linear forwards var(--d);
        stroke-dasharray:var(--length);
        stroke-dashoffset:var(--length);
        stroke-width:35;
        stroke-linecap:round;
        fill:none;
        stroke:#000;
      }
      svg.acjk path[id] {fill:#ccc;}
      ]]>
      </style>
      <path id="z12736d1" d="m 181.00008,288.49997 62.49994,-31.33331 q 62.49994,-31.16663 62.49994,-59.49994 0,-41.66663 -49.99995,-41.66663 -42.66663,0 -48.83329,30.33331 3.66666,0.66666 7.33333,2.49999 5.33332,3 8.33332,8.5 3.16666,5.33332 3.16666,11.16665 0,5.83333 -2.99999,11.16666 -3,5.33333 -8.33333,8.33332 -5.33333,3 -11.16665,3 -5.83333,0 -11.16666,-3 -5.33333,-2.99999 -8.33333,-8.33332 -2.99999,-5.33333 -2.99999,-11.16666 v -10.83332 q 0,-66.6666 74.99993,-66.6666 74.99992,0 74.99992,66.6666 0,43.66662 -75.49992,81.49992 l -49.49996,24.66664 v 10.49999 q 0,41.66663 49.99996,41.66663 49.99995,0 49.99995,-41.66663 v -33.3333 h 24.99997 v 33.3333 q 0,66.66661 -74.99992,66.66661 -74.99993,0 -74.99993,-66.66661 z"/>
      <defs>
        <clipPath id="z12736c1"><use xlink:href="#z12736d1"/></clipPath>
      </defs>
      <path style="--d:0s;--length:1000" clip-path="url(#z12736c1)" d="m 204.34085,194.90119 10.5502,5.55274 3.33165,14.43712 -10.55021,9.99494 -15.54767,-3.33165 -5.55274,-14.43712 12.7713,-49.97467 53.30631,-15.54767 47.19829,8.88438 16.65822,38.31391 -3.88692,34.42699 -39.42445,33.87172 -69.96453,33.31644 -8.88439,8.32911 0.55528,32.2059 10.5502,21.65568 29.42953,16.10295 46.64302,-1.11055 19.98986,-11.10548 14.9924,-22.21096 6.10802,-68.29871 v 0"/>
      </svg>
  
    </body>
    </html>
    ''';

  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    final String contentBase64 = base64Encode(
      const Utf8Encoder().convert(svgData),
    );

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setBackgroundColor(const Color(0x00000000))
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
      ..loadRequest(Uri.parse('data:text/html;base64,$contentBase64'));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
