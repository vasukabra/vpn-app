
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vpn_basic_project/constants/strings.dart';
import 'package:vpn_basic_project/screens/LocationScreen.dart';

import '../main.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';



class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _vpnState = VpnEngine.vpnDisconnected;

  List<VpnConfig> _listVpn = [];

  VpnConfig? _selectedVpn;

  final bool isConnecting = false;

  final bool isConnected = false;

  // void initVpn() async {
  @override
  Widget build(BuildContext context) {
    print('home screen');
    mq = MediaQuery.of(context).size;
    return Scaffold(

      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
          child: Column(
            children: [
              Center(
                child: Text(APP_NAME, style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
              ),
              SizedBox(
                height: 20,
              ),
              changeLocationCard(context),
              SizedBox(
                height: mq.width * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  downloadCard(),
                  uploadCard()
                ]
              ),
              // SizedBox(
              //   height: mq.height * .15,
              // ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset('assets/images/worldImage.png'),
                    Positioned(
                      top: mq.height * .15,
                        child: vpnButton()),
                  ],
                ),
              ),
              SizedBox(
                height: mq.height * .29 ,
              ),
              goPremiumCard(),

            ],
          )
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

  Widget vpnButton(){
    return InkWell(
      child: Container(
        width : mq.width * .45,
        height : mq.height * .25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 10)
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.power_settings_new, size: 40,))),
            SizedBox(
              height: mq.height * 0.01,
            ),
            if(isConnecting)
              Text('Connecting')
            else if(isConnected)
              Text('Connected')
          ],
        ),
      ),
    );
  }

  Widget goPremiumCard(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26)
      ),
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            Icon(FontAwesomeIcons.crown, color: Colors.white,),
            SizedBox(
              width: mq.width * .05,
            ),
            Text('Upgrade to Premium today', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }

  Widget changeLocationCard(BuildContext context){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(FontAwesomeIcons.globe),
            SizedBox(
              width: 10,
            ),
            Text('Select Location', style: TextStyle(fontSize: 16),),
            SizedBox(
              width: mq.width * .30
            ),
            IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationScreen()),
              );
            }, icon: Icon(Icons.arrow_forward_ios_outlined))
          ],
        ),
      ),
    );
  }

  Widget downloadCard(){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: mq.width * 0.35,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color : Colors.green.withOpacity(0.3)
                ),
                child: Icon(Icons.arrow_downward, color: Colors.green,),
              ),
              SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Download:', style: TextStyle(color: Colors.grey),),
                  Text('0 MB')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget uploadCard(){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: mq.width * 0.35,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                    color : Colors.red.withOpacity(0.3)
                ),
                child: Icon(Icons.arrow_upward, color: Colors.red,),
              ),
              SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Upload:', style: TextStyle(color: Colors.grey),),
                  Text('0 MB')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
