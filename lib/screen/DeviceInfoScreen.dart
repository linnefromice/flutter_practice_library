import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class DeviceInfoScreen extends StatelessWidget {
  Widget _buildScaffoldForAndroid() {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
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
                  Card(
                    child: ListTile(
                      title: Text('DEVICE'),
                      subtitle: Text(snapshot.data.display),
                    ),
                  ),
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

  Widget _buildScaffoldForIOS() {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
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
                  Card(
                    child: ListTile(
                      title: Text('DEVICE'),
                      subtitle: Text(snapshot.data.utsname.machine),
                    ),
                  )
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

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return _buildScaffoldForAndroid();
    }
    if (Platform.isIOS) {
      return _buildScaffoldForIOS();
    }
    return Text("SYSTEM ERROR: Judgment impossible");
  }
}