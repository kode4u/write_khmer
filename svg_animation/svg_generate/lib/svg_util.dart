import 'dart:io';
import 'package:xml/xml.dart';

class Util {
  getPath(String filename, String id) async {
    // Read the SVG file
    final file = File(filename);
    if (!await file.exists()) {
      print('File not found: $filename');
      return;
    }

    final svgContent = await file.readAsString();
    final document = XmlDocument.parse(svgContent);
    final pathElements = document.findAllElements('path');
    final pathElement = pathElements.firstWhere(
      (e) => e.getAttribute('id') == id,
    );

    // Extract the 'd' attribute value
    final dValue = pathElement.getAttribute('d');

    print('path $dValue');

    return Future.value(dValue);
    }

  singleStroke(
      {required String path,
      required String clip,
      required String filename,
      int duration = 3,
      int length = 1000,
      int delay = 0}) async{
    var data = """
<svg id="z12736" class="acjk" version="1.1" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<style>
<![CDATA[
@keyframes zk {
	to {
		stroke-dashoffset:0;
	}
}
svg.acjk path[clip-path] {
	--t:${duration}s;
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
<path id="z12736d1" d="$path"/>
<defs>
	<clipPath id="z12736c1"><use xlink:href="#z12736d1"/></clipPath>
</defs>
<path style="--d:${delay}s;--length:$length" clip-path="url(#z12736c1)" d="$clip"/>
</svg>
  """;
  final file = File(filename);
  try {
    // Write data to the file
    await file.writeAsString(data);

    print('Data successfully written to $filename');
  } catch (e) {
    // Handle any errors that might occur
    print('Error writing to file: $e');
  }
    return data;
  }
}
