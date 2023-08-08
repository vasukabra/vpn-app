import 'package:flutter/material.dart';

import 'package:vpn_basic_project/splash_screen/SplashScreen.dart';


late Size mq;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      title: 'OpenVpn Demo',
      home: SplashScreen(),
    );
  }
}
