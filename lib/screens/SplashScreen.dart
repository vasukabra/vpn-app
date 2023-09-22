import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:vpn_basic_project/constants/decoration.dart';

import '../helpers/ad_helper.dart';
import '../main.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      AdHelper.preCacheInterstitialAd();

      //navigate to home
      Get.offAll(() => HomeScreen());
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: app_color_final,
        child: Stack(
          children: [
            //app logo
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                    'assets/logo.png',
                height: mq.height * .2,
                width: mq.width * .3,)),
          ],
        ),
      ),
    );
  }
}