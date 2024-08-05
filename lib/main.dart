import 'package:dictionary/config/k_config.dart';
import 'package:dictionary/screens/main/main_screen.dart';
import 'package:dictionary/services/translation.dart';
import 'package:dictionary/states/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kode4u/screens/k_main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AppState());

  //load data
  Get.find<AppState>().loadData();

  //user
  GetStorage g = GetStorage();
  Map? user = g.read('user');
  if (user != null) {
    Get.find<AppState>().user.value = user;
  }

  setTheme();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      Get.find<AppState>().stopBGMusic();
    } else if (state == AppLifecycleState.resumed) {
      // App is in foreground
      Get.find<AppState>().playBGMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return KMainScreen(translation: translation, pages: [
      GetPage(
        name: '/',
        page: () => const MainScreen(),
      ),
    ]);
  }
}
