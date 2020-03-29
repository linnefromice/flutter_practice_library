import 'package:flutter/material.dart';
import 'package:flutter_practice_library/screen/DeviceInfoScreen.dart';
import 'package:flutter_practice_library/screen/DioScreen.dart';
import 'package:flutter_practice_library/screen/FlutterSwiperScreen.dart';
import 'package:flutter_practice_library/screen/FlutterWebviewPluginScreen.dart';
import 'package:flutter_practice_library/screen/PackageInfoScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_practice_library/screen/SharedPreferencesScreen.dart';
import 'package:flutter_practice_library/screen/SqfliteScreen.dart';

const libraryInformationList = [
  {
    "name": "shared_preferences",
    "description": "Wraps NSUserDefaults (on iOS) and SharedPreferences (on Android).",
    "url": "https://pub.dev/packages/shared_preferences"
  },
  {
    "name": "sqflite",
    "description": "SQLite plugin for Flutter",
    "url": "https://pub.dev/packages/sqflite"
  },
  {
    "name": "dio",
    "description": "A powerful Http client for Dart",
    "url": "https://pub.dev/packages/dio"
  }
];

class MainScreen extends StatelessWidget {
  void _launchUrl(final String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget _buildLibraryInformationCard(final String name, final String description, final String url, final BuildContext context, final Widget screen) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(),
        title: Text(name),
        subtitle: Text(description),
        trailing: RaisedButton.icon(
          onPressed: () => _launchUrl(url),
          icon: Icon(Icons.link),
          label: Text('Link'),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
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
            _buildLibraryInformationCard(
              'shared_preferences',
              'Wraps NSUserDefaults (on iOS) and SharedPreferences (on Android).',
              'https://pub.dev/packages/shared_preferences',
              context,
              SharedPreferencesScreen()
            ),
            _buildLibraryInformationCard(
              'sqflite',
              'SQLite plugin for Flutter',
              'https://pub.dev/packages/sqflite',
              context,
              SqfliteScreen()
            ),
            _buildLibraryInformationCard(
              'dio',
              'A powerful Http client for Dart',
              'https://pub.dev/packages/dio',
              context,
              DioScreen()
            ),
            _buildLibraryInformationCard(
              'package_info',
              'This Flutter plugin provides an API for querying information about an application package.',
              'https://pub.dev/packages/package_info',
              context,
              PackageInfoScreen()
            ),
            _buildLibraryInformationCard(
              'device_info',
              'Get current device information from within the Flutter application.',
              'https://pub.dev/packages/device_info',
              context,
              DeviceInfoScreen()
            ),
            _buildLibraryInformationCard(
              'flutter_webview_plugin',
              'Plugin that allows Flutter to communicate with a native WebView.',
              'https://pub.dev/packages/flutter_webview_plugin',
              context,
              FlutterWebviewPluginScreen(), // dummy
            ),
            _buildLibraryInformationCard(
              'flutter_swiper',
              'The best swiper for flutter , with multiple layouts, infinite loop. Compatible with Android & iOS.',
              'https://pub.dev/packages/flutter_swiper',
              context,
              FlutterSwiperScreen(), // dummy
            ),
            _buildLibraryInformationCard(
              'connectivity',
              'This plugin allows Flutter apps to discover network connectivity and configure themselves accordingly.',
              'https://pub.dev/packages/connectivity',
              context,
              MainScreen(), // dummy
            ),
            _buildLibraryInformationCard(
              'rxdart',
              'RxDart adds additional capabilities to Dart Streams and StreamControllers.',
              'https://pub.dev/packages/rxdart',
              context,
              MainScreen(), // dummy
            ),
            _buildLibraryInformationCard(
              'built_value',
              'Built Values for Dart',
              'https://pub.dev/packages/built_value',
              context,
              MainScreen(), // dummy
            ),
            _buildLibraryInformationCard(
              'battery',
              'A Flutter plugin to access various information about the battery of the device the app is running on.',
              'https://pub.dev/packages/battery',
              context,
              MainScreen(), // dummy
            ),
          ]
        )
      ),
    );
  }
}