import 'package:dictionary/widgets/k_button.dart';
import 'package:dictionary/widgets/k_icon_check_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kode4u/utils/k_utils.dart';

import '../../states/app_state.dart';
import '../../widgets/k_container.dart';

class SettingContent extends StatefulWidget {
  const SettingContent({
    super.key,
  });

  @override
  SettingContentState createState() => SettingContentState();
}

class SettingContentState extends State<SettingContent> {
  double wSmallStar = 48;
  double wBigStar = 64;

  String lang = "english";

  @override
  void initState() {
    super.initState();
    lang = KUtil.isEn() ? "english".tr : "khmer".tr;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin:
                  const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 280,
                  ),
                  const Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: KContainer()),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: -18,
                    child: KButton(
                      'setting'.tr,
                      () {
                        Get.find<AppState>().back();
                      },
                      height: 40,
                      size: 20,
                      marginTop: 4,
                    ),
                  ),
                  // Positioned(
                  //   left: 0,
                  //   right: 0,
                  //   top: -12,
                  //   height: 64,
                  //   child: KButton('', () {}),
                  // ),
                  // Positioned(
                  //   left: 0,
                  //   right: 0,
                  //   top: -6,
                  //   child: KText('setting'.tr, size: 24),
                  // ),
                  // FittedBox(
                  //   child: widget.drawImage,
                  //   fit: BoxFit.contain,
                  // )

                  Positioned(
                      top: 40,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            itemLang(
                              "${'language'.tr}: ${lang.tr}",
                            ),
                            itemMusic("music".tr, () {
                              GetStorage g = GetStorage();
                              Get.find<AppState>().enableMusic =
                                  !Get.find<AppState>().enableMusic;
                              g.write(
                                  'bg_music', Get.find<AppState>().enableMusic);
                              Get.find<AppState>().enableMusic
                                  ? Get.find<AppState>().playBGMusic()
                                  : Get.find<AppState>().stopBGMusic();
                            }),
                            itemSound("sound".tr, () {
                              GetStorage g = GetStorage();
                              Get.find<AppState>().enableSound =
                                  !Get.find<AppState>().enableSound;
                              g.write(
                                  'sound', Get.find<AppState>().enableSound);
                              Get.find<AppState>().enableSound
                                  ? Get.find<AppState>().playTap()
                                  : Get.find<AppState>().stopTap();
                            }),
                            itemLogout("logout".tr, () {
                              //user
                              GetStorage g = GetStorage();
                              g.remove('data');
                              g.remove('user');
                              Get.find<AppState>().resetData();
                              Get.find<AppState>().back();
                            }),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            KButton(
              'close'.tr,
              () {
                Get.find<AppState>().back();
              },
              height: 40,
              size: 20,
              marginTop: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemLang(String name) {
    return GestureDetector(
      onTap: () {
        if (KUtil.isEn()) {
          KUtil.changeToKhmer();
          setState(() {
            lang = 'khmer'.tr;
          });
        } else {
          KUtil.changeToEnglish();
          setState(() {
            lang = 'english'.tr;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 8, top: 8),
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              name,
              style: TextStyle(
                  fontFamily: KUtil.isKh() ? 'Sr' : 'ChangaOne',
                  color: Colors.white,
                  fontSize: 24),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget itemMusic(String name, f) {
    return GestureDetector(
      onTap: f,
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 8, top: 8),
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              name,
              style: TextStyle(
                  fontFamily: KUtil.isKh() ? 'Sr' : 'ChangaOne',
                  color: Colors.white,
                  fontSize: 24),
            ),
            const Spacer(),
            SizedBox(
              width: 64,
              child: KIconCheckButton(
                'assets/ui/ui_tick.svg',
                f,
                height: 32,
                isCheck: Get.find<AppState>().enableMusic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemSound(String name, f) {
    return GestureDetector(
      onTap: f,
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 8, top: 8),
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              name,
              style: TextStyle(
                  fontFamily: KUtil.isKh() ? 'Sr' : 'ChangaOne',
                  color: Colors.white,
                  fontSize: 24),
            ),
            const Spacer(),
            SizedBox(
              width: 64,
              child: KIconCheckButton('assets/ui/ui_tick.svg', f,
                  height: 32, isCheck: Get.find<AppState>().enableSound),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemLogout(String name, f) {
    return GestureDetector(
      onTap: f,
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 8, top: 0),
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              name,
              style: TextStyle(
                  fontFamily: KUtil.isKh() ? 'Sr' : 'ChangaOne',
                  color: Colors.white,
                  fontSize: 24),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 6, right: 10),
              width: 38,
              child: SvgPicture.asset('assets/ui/ui_stop.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
