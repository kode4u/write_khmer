import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary/data/data.dart';
import 'package:flutter/services.dart';
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
  var allData = data.obs;
  var currentKey = ''.obs;
  var selectedIndex = 0.obs;

  bool enableMusic = true;
  bool enableSound = true;

  var user = {}.obs;

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
      SystemNavigator.pop();
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

  void playBGMusic() async {
    if (enableMusic) {
      bgPlayer.stop();
      bgPlayer.play(AssetSource('sounds/bg_music.mp3'), volume: volume);
      await bgPlayer.setReleaseMode(ReleaseMode.loop);
    }
  }

  void stopBGMusic() {
    bgPlayer.stop();
  }

  void playTap() {
    if (enableSound) {
      tapPlayer.play(AssetSource('sounds/tap.mp3'), volume: volume);
    }
  }

  void stopTap() {
    tapPlayer.stop();
  }

  @override
  void dispose() {
    tapPlayer.dispose();
    bgPlayer.dispose();
  }

  int calculateTotalStars() {
    int totalStars = 0;

    // Iterate over all keys in the map
    for (String key in allData.keys) {
      List<dynamic> dataList = allData[key];
      for (var item in dataList) {
        totalStars += int.parse('${item['star']}');
      }
    }
    return totalStars;
  }

  void saveData() {
    GetStorage g = GetStorage();
    g.write('data', jsonEncode(allData));
  }

  void loadData() {
    GetStorage g = GetStorage();
    String? jsonString = g.read('data');
    if (jsonString != null) {
      allData.value = jsonDecode(jsonString);
    }
    //calcute score
    score.value = calculateTotalStars();
  }

  void resetData() {
    //when logout
    user.value = {};
    allData.value = data;
    score.value = 0;
  }
}
