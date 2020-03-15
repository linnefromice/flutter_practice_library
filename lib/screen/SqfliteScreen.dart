import 'package:flutter/material.dart';

class SqfliteScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Practice - sqflite"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Practice - sqflite"'),
            RaisedButton(
              child: Text('BUTTON'),
              onPressed: null,
            )
          ],
        )
      ),
    );
  }
}
