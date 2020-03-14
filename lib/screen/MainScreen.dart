import 'package:flutter/material.dart';
import 'package:flutter_practice_library/screen/SharedPreferencesScreen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Practice Library"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: FlutterLogo(),
              title: Text('shared_preferences'),
              subtitle: Text('https://pub.dev/packages/shared_preferences'),
              // trailing: use UrlLauncher,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SharedPreferencesScreen()),
                );
              },
            ),
            ListTile(
              leading: FlutterLogo(),
              title: Text('sqflite'),
              subtitle: Text('https://pub.dev/packages/sqflite'),
            ),
          ]
        )
      ),
    );
  }
}