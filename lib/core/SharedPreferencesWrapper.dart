import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<dynamic> getValue(key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(key);
  }

  static Future<void> setInt(key, value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  static Future<void> setString(key, value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }
}