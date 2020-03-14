import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesScreen extends StatelessWidget {
  final keyName = 'keyOne';

  void _read() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(keyName) ?? 0;
    print('read: $value');
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    var value = prefs.getInt(keyName) ?? 0;
    value++;
    prefs.setInt(keyName, value);
    print('saved $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Practice - shared_preferences"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('SAVE'),
                onPressed: _save,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('READ'),
                onPressed: _read,
              ),
            )
          ],
        )
      ),
    );
  }
}