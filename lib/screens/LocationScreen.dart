import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/constants/decoration.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart';
import 'package:vpn_basic_project/screens/VpnCard.dart';

import '../main.dart';

class LocationScreen extends StatelessWidget{

  final controller = LocationController();

  @override
  Widget build(BuildContext context) {
    if (controller.vpnList.isEmpty) controller.getVpnList();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: BackButton(
          ),
          titleTextStyle: TextStyle(
            fontFamily: 'Cabin',
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          backgroundColor: app_color_final,
          title:  Text('VPN Locations',),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 20, right: 10),
          child: FloatingActionButton(
            child: Icon(Icons.refresh_rounded),
            onPressed: (){
              controller.getVpnList();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child:  controller.isLoading.value ? loadingWidget()
                : controller.vpnList.isEmpty ? noVpnFound() : vpnListWidget(),)
        )
    );
  }

  loadingWidget(){
    return Center(child: SizedBox(
      width: mq.width * .3,
        child: Lottie.asset('assets/lottie/loading.json')));
  }

  vpnListWidget(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.vpnList.length,
        itemBuilder: (context, index ) => VpnCard (vpn: controller.vpnList[index]) );
  }

  noVpnFound(){
    return Text('No vpns found');
  }
}