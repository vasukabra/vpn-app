import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_basic_project/helpers/config.dart';
import 'package:vpn_basic_project/screens/SplashScreen.dart';

import 'helpers/ad_helper.dart';
import 'helpers/pref.dart';


late Size mq;
late SharedPreferences sharedPreferences;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool('isPremium', false);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  await Firebase.initializeApp();

  await Config.initConfig();

  await Pref.initializeHive();
  await AdHelper.initAds();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((v) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Cabin'),
      title: 'Flash VPN',
      home: SplashScreen(),
    );
  }
}
