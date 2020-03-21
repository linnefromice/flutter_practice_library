import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class PackageInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return Scaffold(
      appBar: AppBar(
        title: Text('Practice - package_info'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Text('Practice - package_info'),
            /*
            Card(
              child: ListTile(
                title: Text("App Name"),
                subtitle: Text(packageInfo.appName),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Package Name"),
                subtitle: Text(packageInfo.packageName),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Version"),
                subtitle: Text(packageInfo.version),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Build Number"),
                subtitle: Text(packageInfo.buildNumber),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}