import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:kode4u/utils/k_ads.dart';

class AppState extends GetxController {
  var score = 0.obs;
  var progress = 0.obs;
  double volume = 0.5;
  KAds ads = KAds();
  final AudioPlayer bgPlayer = AudioPlayer();
  final AudioPlayer tapPlayer = AudioPlayer();
  var lastSelectedIndex = 0.obs;
  var currentIndex = 0.obs;
  var data = [
    {
      'c': 'ក',
      'star': 0,
      'p': 'alphas',
      's': 'sounds',
    }
  ].obs;

  var selectedContent = 0.obs;

  AppState();

  void playBGMusic() {
    bgPlayer.play(AssetSource('sounds/bg_music.mp3'), volume: volume);
  }

  void playTap() {
    bgPlayer.play(AssetSource('sounds/tap.mp3'), volume: volume);
  }
}
