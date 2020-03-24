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
                  _createDeviceInfoCard('version.incremental', _info.version.incremental),
                  _createDeviceInfoCard('version.codename', _info.version.codename),
                  _createDeviceInfoCard('version.baseOS', _info.version.baseOS),
                  _createDeviceInfoCard('board', _info.board),
                  _createDeviceInfoCard('bootloader', _info.bootloader),
                  _createDeviceInfoCard('brand', _info.brand),
                  _createDeviceInfoCard('device', _info.device),
                  _createDeviceInfoCard('display', _info.display),
                  _createDeviceInfoCard('fingerprint', _info.fingerprint),
                  _createDeviceInfoCard('hardware', _info.hardware),
                  _createDeviceInfoCard('host', _info.host),
                  _createDeviceInfoCard('id', _info.id),
                  _createDeviceInfoCard('manufacturer', _info.manufacturer),
                  _createDeviceInfoCard('model', _info.model),
                  _createDeviceInfoCard('product', _info.product),
                  _createDeviceInfoCard('supported32BitAbis', _info.supported32BitAbis.toString()),
                  _createDeviceInfoCard('supported64BitAbis', _info.supported64BitAbis.toString()),
                  _createDeviceInfoCard('supportedAbis', _info.supportedAbis.toString()),
                  _createDeviceInfoCard('tags', _info.tags),
                  _createDeviceInfoCard('type', _info.type),
                  _createDeviceInfoCard('isPhysicalDevice', _info.isPhysicalDevice.toString()),
                  _createDeviceInfoCard('androidId', _info.androidId),
                  _createDeviceInfoCard('systemFeatures', _info.systemFeatures.toString()),
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
                  _createDeviceInfoCard('localizedModel', _info.localizedModel),
                  _createDeviceInfoCard('identifierForVendor', _info.identifierForVendor),
                  _createDeviceInfoCard('isPhysicalDevice', _info.isPhysicalDevice.toString()),
                  _createDeviceInfoCard('utsname.sysname', _info.utsname.sysname),
                  _createDeviceInfoCard('utsname.nodename', _info.utsname.nodename),
                  _createDeviceInfoCard('utsname.release', _info.utsname.release),
                  _createDeviceInfoCard('utsname.machine', _info.utsname.machine),
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