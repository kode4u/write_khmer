import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary/screens/main/main_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kode4u/utils/k_ads.dart';

import '../screens/main/main_screen.dart';

class AppState extends GetxController {
  List stack = [];
  var score = 0.obs;
  var progress = 0.obs;
  double volume = 0.5;
  KAds ads = KAds();
  final AudioPlayer bgPlayer = AudioPlayer();
  final AudioPlayer tapPlayer = AudioPlayer();
  var currentScreen = Screen.main.obs;
  var data = [
    {
      'c': 'ក',
      'star': 0,
      'p': 'alphas',
      's': 'sounds',
    }
  ].obs;

  var selectedIndex = 0.obs;

  bool enableMusic = true;
  bool enableSound = true;

  void switchScreen(String name) {
    if (stack.contains(name)) {
      stack.remove(name);
    }
    stack.add(currentScreen.value);
    currentScreen.value = name;
  }

  void back() {
    if (currentScreen.value == Screen.main) {
      stack.clear();
      return;
    }
    if (stack.isEmpty) return;
    var screenName = stack[stack.length - 1];
    stack.removeAt(stack.length - 1);
    currentScreen.value = screenName;
  }

  AppState() {
    initData();
  }

  void initData() async {
    GetStorage g = GetStorage();
    enableMusic = g.read('bg_music') ?? true;
    enableSound = g.read('sound') ?? true;
  }

  void playBGMusic() {
    if (enableMusic) {
      bgPlayer.play(AssetSource('sounds/bg_music.mp3'), volume: volume);
    }
  }

  void stopBGMusic() {
    bgPlayer.stop();
  }

  void playTap() {
    if (enableSound) {
      bgPlayer.play(AssetSource('sounds/tap.mp3'), volume: volume);
    }
  }

  void stopTap() {
    bgPlayer.stop();
  }
}
