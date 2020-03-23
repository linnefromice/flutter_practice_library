import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class PackageInfoScreen extends StatelessWidget {
  Widget _createPackageInfoCard(String title, String information) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(information),
      ),
    );
  }

  Widget _buildPackageInfo(PackageInfo packageInfo) {

    List<Widget> _widgetList = [];
    _widgetList.add(
      Card(
        child: ListTile(
          title: Text('Practice - package_info'),
        ),
      )
    );
    if (packageInfo.appName != null) {
      _widgetList.add(_createPackageInfoCard("App Name", packageInfo.appName));
    }
    if (packageInfo.packageName != null) {
      _widgetList.add(_createPackageInfoCard("Package Name", packageInfo.packageName));
    }
    if (packageInfo.version != null) {
      _widgetList.add(_createPackageInfoCard("Version", packageInfo.version));
    }
    if (packageInfo.buildNumber != null) {
      _widgetList.add(_createPackageInfoCard("Build Number", packageInfo.buildNumber));
    }
    return ListView(
      children: _widgetList
    );
  }

  Widget _buildNoData() {
    return ListView(
      children: <Widget>[
        Text('Practice - package_info'),
        Text('NODATA'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice - package_info'),
      ),
      body: Center(
        child: FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
            if (snapshot.hasData) {
              return _buildPackageInfo(snapshot.data);
            } else {
              return _buildNoData();
            }
          },
        ),
      ),
    );
  }
}