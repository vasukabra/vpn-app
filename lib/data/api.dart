

import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/dialogs.dart';
import 'package:vpn_basic_project/models/VpnModel.dart';

import '../helpers/pref.dart';
class ApiCall {

  static Future<List<VpnModel>> getVPNList() async {
    final List<VpnModel> vpnList = [];

    try {
      final res = await get(Uri.parse('http://www.vpngate.net/api/iphone/'));
      final csvString = res.body.split("#")[1].replaceAll('*', '');

      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);
      final header = list[0];

      for (int i = 1; i < list.length - 1; ++i) {
        Map<String, dynamic> tempJson = {};

        for (int j = 0; j < header.length; ++j) {
          tempJson.addAll({header[j].toString(): list[i][j]});
        }
        vpnList.add(VpnModel.fromJson(tempJson));
      }
    } catch (e) {
      Dialogs.error(msg: e.toString());
      log('\ngetVPNServersE: $e');
    }
    vpnList.shuffle();

    if (vpnList.isNotEmpty) Pref.vpnList = vpnList;

    return vpnList;
  }
}