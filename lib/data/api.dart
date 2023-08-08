import 'dart:convert';
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/models/VpnModel.dart';
class ApiCall {
  static Future<void> getVpnList() async {
    final List<VpnModel> vpnList = [];
    var url = Uri.parse('http://www.vpngate.net/api/iphone/');
    final response = await get(url);
    final csvString = response.body.split('#')[1].replaceAll('*', '');
    List<List<dynamic>> list = const CsvToListConverter().convert(csvString);
    final header = list[0];
    for(int i = 1; i < header.length; ++i){
      Map<String , dynamic> tempJson = {};
      for(int j = 0; j < header.length; ++j){
        tempJson.addAll({header[j].toString() : list[i][j]});
      }
      vpnList.add(VpnModel.fromJson(tempJson));
    }
    print(vpnList.elementAt(0).CountryLong);
  }
}