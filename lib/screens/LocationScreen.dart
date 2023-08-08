import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/data/api.dart';

class LocationScreen extends StatefulWidget{

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  @override
  Widget build(BuildContext context) {
    print('Location screen');
    return Scaffold(
      appBar: AppBar(
        title: Text('Location screen'),
      ),
    );
  }

  loadingWidget(){
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Lottie.asset('assets/lottie/loading.json'),
    );
  }
}