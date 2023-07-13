import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:vpn_basic_project/constants/strings.dart';

import '../models/vpn_config.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';



class HomeScreen extends StatelessWidget {
  String _vpnState = VpnEngine.vpnDisconnected;
  List<VpnConfig> _listVpn = [];
  VpnConfig? _selectedVpn;

  // void initVpn() async {
  //   //sample vpn config file (you can get more from https://www.vpngate.net/)
  //   _listVpn.add(VpnConfig(
  //       config: await rootBundle.loadString('assets/vpn/japan.ovpn'),
  //       country: 'Japan',
  //       username: 'vpn',
  //       password: 'vpn'));
  //
  //   _listVpn.add(VpnConfig(
  //       config: await rootBundle.loadString('assets/vpn/thailand.ovpn'),
  //       country: 'Thailand',
  //       username: 'vpn',
  //       password: 'vpn'));
  //
  //   SchedulerBinding.instance.addPostFrameCallback(
  //       (t) => setState(() => _selectedVpn = _listVpn.first));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.workspace_premium))
        ],
      ),
    );
  }

  void _connectClick() {
    ///Stop right here if user not select a vpn
    if (_selectedVpn == null) return;

    if (_vpnState == VpnEngine.vpnDisconnected) {
      ///Start if stage is disconnected
      VpnEngine.startVpn(_selectedVpn!);
    } else {
      ///Stop if stage is "not" disconnected
      VpnEngine.stopVpn();
    }
  }
}
