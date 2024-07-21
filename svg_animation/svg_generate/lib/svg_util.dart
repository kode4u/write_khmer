import 'dart:io';
import 'package:xml/xml.dart';

class Util {
  getPath(String dir, String filename, String id) async {
    print('$dir/$filename');
    // Read the SVG file
    final file = File('$dir/$filename');
    if (!await file.exists()) {
      print('File not found: $dir/$filename');
      return;
    }

    final svgContent = await file.readAsString();
    final document = XmlDocument.parse(svgContent);
    final pathElements = document.findAllElements('path');
    final pathElement = pathElements.firstWhere(
      (e) => e.getAttribute('id') == id,
    );
    final dValue = pathElement.getAttribute('d');

    return Future.value(dValue);
  }

  singleStroke(
      {required String path,
      required String clip,
      required String filename,
      required String dir,
      required String output,
      int duration = 3,
      int length = 1000,
      int delay = 0}) async {
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
	stroke-width:40;
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
    final file = File('$output/$filename');
    try {
      // Write data to the file
      await file.writeAsString(data);
      print('Data successfully written to $output/$filename');
    } catch (e) {
      // Handle any errors that might occur
      print('Error writing to file: $e');
    }
    return data;
  }

  twoStroke(
      {required String text,
      required String path1,
      required String path2,
      required String filename,
      required String dir,
      required String output,
      int duration = 3,
      int length = 1000,
      int delay = 0}) async {
    var data = """
<svg id="z20023" class="acjk" version="1.1" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<style>
<![CDATA[
@keyframes zk {
	to {
		stroke-dashoffset:0;
	}
}
svg.acjk path[clip-path] {
	--t:0.8s;
	animation:zk var(--t) linear forwards var(--d);
	stroke-dasharray:3337;
	stroke-dashoffset:3339;
	stroke-width:40;
	stroke-linecap:round;
	fill:none;
	stroke:#000;
}
svg.acjk path[id] {fill:#ccc;}
]]>
</style>
<path id="z20023d1" d="$text"/>
<path id="z20023d2" d="$text"/>
<defs>
	<clipPath id="z20023c1"><use xlink:href="#z20023d1"/></clipPath>
	<clipPath id="z20023c2"><use xlink:href="#z20023d2"/></clipPath>
</defs>
<path style="--d:1s;" pathLength="3333" clip-path="url(#z20023c1)" d="$path1"/>
<path style="--d:2s;" pathLength="3333" clip-path="url(#z20023c2)" d="$path2"/>
</svg>
  """;
    final file = File('$output/$filename');
    try {
      // Write data to the file
      await file.writeAsString(data);

      print('Data successfully written to $output/$filename');
    } catch (e) {
      // Handle any errors that might occur
      print('Error writing to file: $e');
    }
    return data;
  }

  threeStroke(
      {required String text,
      required String path1,
      required String path2,
      required String path3,
      required String filename,
      required String dir,
      required String output,
      int duration = 3,
      int length = 1000,
      int delay = 0}) async {
    var data = """
<svg id="z17553" class="acjk" version="1.1" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<style>
<![CDATA[
@keyframes zk {
	to {
		stroke-dashoffset:0;
	}
}
svg.acjk path[clip-path] {
	--t:0.8s;
	animation:zk var(--t) linear forwards var(--d);
	stroke-dasharray:3337;
	stroke-dashoffset:3339;
	stroke-width:40;
	stroke-linecap:round;
	fill:none;
	stroke:#000;
}
svg.acjk path[id] {fill:#ccc;}
]]>
</style>
<path id="z17553d1" d="$text"/>
<path id="z17553d2" d="$text"/>
<path id="z17553d3" d="$text"/>
<defs>
	<clipPath id="z17553c1"><use xlink:href="#z17553d1"/></clipPath>
	<clipPath id="z17553c2"><use xlink:href="#z17553d2"/></clipPath>
	<clipPath id="z17553c3"><use xlink:href="#z17553d3"/></clipPath>
</defs>
<path style="--d:1s;" pathLength="3333" clip-path="url(#z17553c1)" d="$path1"/>
<path style="--d:2s;" pathLength="3333" clip-path="url(#z17553c2)" d="$path2"/>
<path style="--d:3s;" pathLength="3333" clip-path="url(#z17553c3)" d="$path3"/>
</svg>
  """;
    final file = File('$output/$filename');
    try {
      // Write data to the file
      await file.writeAsString(data);

      print('Data successfully written to $output/$filename');
    } catch (e) {
      // Handle any errors that might occur
      print('Error writing to file: $e');
    }
    return data;
  }

  fourStroke(
      {required String text,
      required String path1,
      required String path2,
      required String path3,
      required String path4,
      required String filename,
      required String dir,
      required String output,
      int duration = 3,
      int length = 1000,
      int delay = 0}) async {
    var data = """
<svg id="z20013" class="acjk" version="1.1" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<style>
<![CDATA[
@keyframes zk {
	to {
		stroke-dashoffset:0;
	}
}
svg.acjk path[clip-path] {
	--t:0.8s;
	animation:zk var(--t) linear forwards var(--d);
	stroke-dasharray:3337;
	stroke-dashoffset:3339;
	stroke-width:35;
	stroke-linecap:round;
	fill:none;
	stroke:#000;
}
svg.acjk path[id] {fill:#ccc;}
]]>
</style>
<path id="z20013d1" d="$text"/>
<path id="z20013d2" d="$text"/>
<path id="z20013d3" d="$text"/>
<path id="z20013d4" d="$text"/>
<defs>
	<clipPath id="z20013c1"><use xlink:href="#z20013d1"/></clipPath>
	<clipPath id="z20013c2"><use xlink:href="#z20013d2"/></clipPath>
	<clipPath id="z20013c3"><use xlink:href="#z20013d3"/></clipPath>
	<clipPath id="z20013c4"><use xlink:href="#z20013d4"/></clipPath>
</defs>
<path style="--d:1s;" pathLength="3333" clip-path="url(#z20013c1)" d="$path1"/>
<path style="--d:2s;" pathLength="3333" clip-path="url(#z20013c2)" d="$path2"/>
<path style="--d:3s;" pathLength="3333" clip-path="url(#z20013c3)" d="$path3"/>
<path style="--d:4s;" pathLength="3333" clip-path="url(#z20013c4)" d="$path4"/>
</svg>
  """;
    final file = File('$output/$filename');
    try {
      // Write data to the file
      await file.writeAsString(data);

      print('Data successfully written to $output/$filename');
    } catch (e) {
      // Handle any errors that might occur
      print('Error writing to file: $e');
    }
    return data;
  }
}
