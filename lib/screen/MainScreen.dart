import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_practice_library/screen/SharedPreferencesScreen.dart';
import 'package:flutter_practice_library/screen/SqfliteScreen.dart';

class MainScreen extends StatelessWidget {
  void _launchUrl(final String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Practice Library"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('shared_preferences'),
                subtitle: Text('Wraps NSUserDefaults (on iOS) and SharedPreferences (on Android).'),
                trailing: RaisedButton.icon(
                  onPressed: () => _launchUrl('https://pub.dev/packages/shared_preferences'),
                  icon: Icon(Icons.link),
                  label: Text('Link'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SharedPreferencesScreen()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('sqflite'),
                subtitle: Text('SQLite plugin for Flutter'),
                trailing: RaisedButton.icon(
                  onPressed: () => _launchUrl('https://pub.dev/packages/sqflite'),
                  icon: Icon(Icons.link),
                  label: Text('Link'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SqfliteScreen()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('dio'),
                subtitle: Text('A powerful Http client for Dart'),
                trailing: RaisedButton.icon(
                  onPressed: () => _launchUrl('https://pub.dev/packages/dio'),
                  icon: Icon(Icons.link),
                  label: Text('Link'),
                ),
              ),
            ),
          ]
        )
      ),
    );
  }
}