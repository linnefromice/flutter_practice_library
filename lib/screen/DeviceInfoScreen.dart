import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class DeviceInfoScreen extends StatelessWidget {
  Widget _createDeviceInfoCard(String title, String information) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(information),
      ),
    );
  }

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
              AndroidDeviceInfo _info = snapshot.data;
              return ListView(
                children: <Widget>[
                  _createDeviceInfoCard('version.securityPatch', _info.version.securityPatch),
                  _createDeviceInfoCard('version.sdkInt', _info.version.sdkInt.toString()),
                  _createDeviceInfoCard('version.release', _info.version.release),
                  _createDeviceInfoCard('version.previewSdkInt', _info.version.previewSdkInt.toString()),
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
              IosDeviceInfo _info = snapshot.data;
              return ListView(
                children: <Widget>[
                  _createDeviceInfoCard('name', _info.name),
                  _createDeviceInfoCard('systemName', _info.systemName),
                  _createDeviceInfoCard('systemVersion', _info.systemVersion),
                  _createDeviceInfoCard('model', _info.model),
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