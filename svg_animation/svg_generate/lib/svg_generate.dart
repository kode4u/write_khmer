import 'dart:io';

import 'package:svg_generate/svg_util.dart';

void main() async {
  processOneStroke();
  processTwoStroke();
  processThreeStroke();
  processFourStroke();
}

void processFourStroke() async {
  final directoryPath = 'input/fourstroke';
  final outputDirectory = 'processed/fourstroke';
  // Get the directory
  final directory = Directory(directoryPath);
  if (directory.existsSync()) {
    // List all files in the directory
    final files = directory.listSync();
    // Loop through each file and call the function
    for (var file in files) {
      if (file is File) {
        final filename = file.uri.pathSegments.last;
        if (filename.endsWith('.svg')) {
          await processFileFourStroke(filename, directoryPath, outputDirectory);
        }
      }
    }
  } else {
    print('Directory does not exist');
  }
}

void processThreeStroke() async {
  final directoryPath = 'input/threestroke';
  final outputDirectory = 'processed/threestroke';
  // Get the directory
  final directory = Directory(directoryPath);
  if (directory.existsSync()) {
    // List all files in the directory
    final files = directory.listSync();
    // Loop through each file and call the function
    for (var file in files) {
      if (file is File) {
        final filename = file.uri.pathSegments.last;
        if (filename.endsWith('.svg')) {
          print('file $filename, $directoryPath');
          await processFileThreeStroke(
              filename, directoryPath, outputDirectory);
        }
      }
    }
  } else {
    print('Directory does not exist');
  }
}

void processOneStroke() async {
  final directoryPath = 'input/onestroke';
  final outputDirectory = 'processed/onestroke';
  // Get the directory
  final directory = Directory(directoryPath);
  if (directory.existsSync()) {
    // List all files in the directory
    final files = directory.listSync();
    // Loop through each file and call the function
    for (var file in files) {
      if (file is File) {
        final filename = file.uri.pathSegments.last;
        if (filename.endsWith('.svg')) {
          print('file $filename, $directoryPath');
          await processFile(filename, directoryPath, outputDirectory);
        }
      }
    }
  } else {
    print('Directory does not exist');
  }
}

void processTwoStroke() async {
  final directoryPath = 'input/twostroke';
  final outputDirectory = 'processed/twostroke';

  // Get the directory
  final directory = Directory(directoryPath);
  if (directory.existsSync()) {
    // List all files in the directory
    final files = directory.listSync();
    // Loop through each file and call the function
    for (var file in files) {
      if (file is File) {
        final filename = file.uri.pathSegments.last;
        if (filename.endsWith('.svg')) {
          await processFileTwoStroke(filename, directoryPath, outputDirectory);
        }
      }
    }
  } else {
    print('Directory does not exist');
  }
}

// Function to process each file
Future<void> processFile(String filename, String dir, String output) async {
  Util u = Util();
  String text1 = await u.getPath(dir, filename, 'text1');
  String path1 = await u.getPath(dir, filename, 'path1');
  await u.singleStroke(
      path: text1, clip: path1, filename: filename, dir: dir, output: output);
}

// Function to process each file
Future<void> processFileTwoStroke(
    String filename, String dir, String output) async {
  Util u = Util();
  String text1 = await u.getPath(dir, filename, 'text1');
  String path1 = await u.getPath(dir, filename, 'path1');
  String path2 = await u.getPath(dir, filename, 'path2');
  await u.twoStroke(
      text: text1,
      path1: path1,
      path2: path2,
      filename: filename,
      dir: dir,
      output: output);
}

Future<void> processFileThreeStroke(
    String filename, String dir, String output) async {
  Util u = Util();
  String text1 = await u.getPath(dir, filename, 'text1');
  String path1 = await u.getPath(dir, filename, 'path1');
  String path2 = await u.getPath(dir, filename, 'path2');
  String path3 = await u.getPath(dir, filename, 'path3');
  await u.threeStroke(
      text: text1,
      path1: path1,
      path2: path2,
      path3: path3,
      filename: filename,
      dir: dir,
      output: output);
}

Future<void> processFileFourStroke(
    String filename, String dir, String output) async {
  Util u = Util();
  String text1 = await u.getPath(dir, filename, 'text1');
  String path1 = await u.getPath(dir, filename, 'path1');
  String path2 = await u.getPath(dir, filename, 'path2');
  String path3 = await u.getPath(dir, filename, 'path3');
  String path4 = await u.getPath(dir, filename, 'path4');
  await u.fourStroke(
      text: text1,
      path1: path1,
      path2: path2,
      path3: path3,
      path4: path4,
      filename: filename,
      dir: dir,
      output: output);
}
