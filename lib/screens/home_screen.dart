import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/constants/strings.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/screens/HomeCard.dart';
import 'package:vpn_basic_project/screens/LocationScreen.dart';
import 'package:vpn_basic_project/screens/count_down_timer.dart';
import 'package:vpn_basic_project/screens/payment_screen.dart';

import '../constants/decoration.dart';
import '../main.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      controller.vpnState.value = event;
    });
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage('assets/logo.png'),
                    ),
                  ),
                  Center(
                    child: Text(
                      APP_NAME,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .04,
              ),
              changeLocationCard(),
              SizedBox(
                height: mq.height * .02,
              ),
              Obx(() => _vpnButtonTut()),
              SizedBox(
                height: mq.height * .02,
              ),
              Obx(() => statusCard()),
              SizedBox(
                height: mq.height * .02,
              ),
              Obx(() => CountDownTimer(
                  startTimer:
                      controller.vpnState.value == VpnEngine.vpnConnected)),
              SizedBox(
                height: mq.height * .03,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCard(
                        icon: CircleAvatar(
                          child: controller.vpn.value.countryLong.isEmpty
                              ? Icon(Icons.map_rounded)
                              : null,
                          backgroundImage: controller
                                  .vpn.value.countryLong.isEmpty
                              ? null
                              : AssetImage(
                                  'assets/images/flags/${controller.vpn.value.countryShort.toLowerCase()}.png'),
                        ),
                        title: controller.vpn.value.countryLong.isEmpty
                            ? 'Country'
                            : controller.vpn.value.countryLong.toString(),
                        subtitle: 'Free'),
                    HomeCard(
                        icon: CircleAvatar(
                          backgroundColor: Color(0xffAA91E4),
                          child: Icon(
                            Icons.equalizer_rounded,
                            color: Colors.white,
                          ),
                        ),
                        title: controller.vpn.value.countryLong.isEmpty
                            ? '100 ms'
                            : controller.vpn.value.ping.toString() + ' ms',
                        subtitle: 'PING')
                  ],
                ),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              StreamBuilder<VpnStatus?>(
                  initialData: VpnStatus(),
                  stream: VpnEngine.vpnStatusSnapshot(),
                  builder: (context, snapshot) {
                    final downloadSpeed = snapshot.data?.byteIn ?? '0 kbps';
                    final uploadSpeed = snapshot.data?.byteOut ?? '0 kbps';
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HomeCard(
                            icon: CircleAvatar(
                              backgroundColor: Color(0xffE98D89),
                              child: Icon(
                                Icons.arrow_downward_rounded,
                                color: Colors.white,
                              ),
                            ),
                            title: downloadSpeed,
                            subtitle: 'DOWNLOAD'),
                        HomeCard(
                            icon: CircleAvatar(
                              backgroundColor: Color(0xff8BADE8),
                              child: Icon(
                                Icons.arrow_upward_rounded,
                                color: Colors.white,
                              ),
                            ),
                            title: uploadSpeed,
                            subtitle: 'UPLOAD')
                      ],
                    );
                  }),
              SizedBox(
                height: mq.height * .05,
              ),
              goPremiumCard()
            ],
          )),
    );
  }

  // void _connectClick() {
  Widget vpnButton() {
    return InkWell(
      onTap: () {
        controller.connectToVpn();
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: controller.getButtonColor.withOpacity(.3)),
        child: Container(
            width: mq.width * .30,
            height: mq.height * .25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: app_color_final, width: 15)),
            child: Icon(Icons.power_settings_new_rounded,
                color: app_color_final, size: 30)),
      ),
    );
  }

  Widget goPremiumCard() {
    return InkWell(
      onTap: () {
        Get.to(() => PaymentScreen());
      },
      child: Container(
        height: mq.height * .05,
        width: mq.width * .8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get Premium',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }

  Widget changeLocationCard() {
    return InkWell(
      onTap:  () {
      Get.to(() => LocationScreen());
    },
      child: Container(
        height: 50,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 2, color: app_color_final)),
          child: Padding(
            padding: EdgeInsets.only(left: 24),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.globe,
                  size: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Select Location',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: mq.width * .30),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statusCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
          color: app_color_final, borderRadius: BorderRadius.circular(25)),
      child: Text(
        controller.vpnState.value == VpnEngine.vpnDisconnected
            ? 'Not Connected'
            : controller.vpnState.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(fontSize: 12.5, color: Colors.white),
      ),
    );
  }

  Widget _vpnButtonTut() => Column(children: [
        //button
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {
              controller.connectToVpn();
            },
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.getButtonColor.withOpacity(.1)),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.getButtonColor.withOpacity(.3)),
                child: Container(
                  width: mq.height * .14,
                  height: mq.height * .14,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: controller.getButtonColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //icon
                      Icon(
                        Icons.power_settings_new,
                        size: 28,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text(
                        controller.getButtonText,
                        style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )

                      //text
                      // Text(
                      //   controller.getButtonText,
                      //   style: TextStyle(
                      //       fontSize: 12.5,
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.w500),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]);
}
