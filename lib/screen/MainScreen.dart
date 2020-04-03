import 'package:flutter/material.dart';
import 'package:flutter_practice_library/screen/DeviceInfoScreen.dart';
import 'package:flutter_practice_library/screen/DioScreen.dart';
import 'package:flutter_practice_library/screen/FlutterSwiperScreen.dart';
import 'package:flutter_practice_library/screen/FlutterWebviewPluginScreen.dart';
import 'package:flutter_practice_library/screen/PackageInfoScreen.dart';
import 'package:flutter_practice_library/screen/practice/PracticeBlocAndStatefulWidgetScreen.dart';
import 'package:flutter_practice_library/screen/practice/PracticeDioAndFutureScreen.dart';
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
  },
  {
    "name": "package_info",
    "description": "This Flutter plugin provides an API for querying information about an application package.",
    "url": "https://pub.dev/packages/package_info"
  },
  {
    "name": "device_info",
    "description": "Get current device information from within the Flutter application.",
    "url": "https://pub.dev/packages/device_info"
  },
  {
    "name": "flutter_webview_plugin",
    "description": "Plugin that allows Flutter to communicate with a native WebView.",
    "url": "https://pub.dev/packages/flutter_webview_plugin"
  },
  {
    "name": "flutter_swiper",
    "description": "The best swiper for flutter , with multiple layouts, infinite loop. Compatible with Android & iOS.",
    "url": "https://pub.dev/packages/flutter_swiper"
  },
  {
    "name": "connectivity",
    "description": "This plugin allows Flutter apps to discover network connectivity and configure themselves accordingly.",
    "url": "https://pub.dev/packages/connectivity"
  },
  {
    "name": "rxdart",
    "description": "RxDart adds additional capabilities to Dart Streams and StreamControllers.",
    "url": "https://pub.dev/packages/rxdart"
  },
  {
    "name": "built_value",
    "description": "Built Values for Dart",
    "url": "https://pub.dev/packages/built_value"
  },
  {
    "name": "battery",
    "description": "A Flutter plugin to access various information about the battery of the device the app is running on.",
    "url": "https://pub.dev/packages/battery"
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

  Widget _buildDrawer(final BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: ListTile(
              title: Text('Dummy Pages'),
              subtitle: Text('For Practice'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('PracticeBlocAndStatefulWidget'),
            subtitle: Text('bloc X StatefulWidget'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PracticeBlocAndStatefulWidgetScreen()),
              );
            },
          ),
          ListTile(
            title: Text('PracticeDioAndFuture'),
            subtitle: Text('Dio with FutureBuilder'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PracticeDioAndFutureScreen()),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildBody(final BuildContext context) {
    return Center(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Practice Library"),
      ),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
    );
  }
}