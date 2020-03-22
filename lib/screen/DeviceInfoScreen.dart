import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class DeviceInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Practice - device_info'),
        ),
        body: Center(
          child: FutureBuilder(
            future: deviceInfo.androidInfo,
            builder: (BuildContext context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Text("DEVICE"),
                    Text(snapshot.data.display)
                  ],
                );
              } else {
                return Text('NODATA');
              }
            },
          ),
        ),
      );
    }
    if (Platform.isIOS) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Practice - device_info'),
        ),
        body: Center(
          child: FutureBuilder(
            future: deviceInfo.iosInfo,
            builder: (BuildContext context, AsyncSnapshot<IosDeviceInfo> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Text("DEVICE"),
                    Text(snapshot.data.utsname.machine)
                  ],
                );
              } else {
                return Text('NODATA');
              }
            },
          ),
        ),
      );
    }
    return Text("SYSTEM ERROR: Judgment impossible");
  }
}