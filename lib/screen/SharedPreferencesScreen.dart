import 'package:flutter/material.dart';
import 'package:flutter_practice_library/core/SharedPreferencesWrapper.dart';

class SharedPreferencesScreen extends StatelessWidget {
  final keyName = 'keyOne';

  void _read() async {
    final value = await SharedPreferencesWrapper.getValue(keyName) ?? 0;
    print('read: $value');
  }

  void _save() async {
    int value = await SharedPreferencesWrapper.getValue(keyName) ?? 0;
    value++;
    SharedPreferencesWrapper.setInt(keyName, value);
    print('saved $value');
  }

  void _reset() async {
    SharedPreferencesWrapper.setInt(keyName, 0);
    print('reset');
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
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('RESET'),
                onPressed: _reset,
              ),
            ),
          ],
        )
      ),
    );
  }
}