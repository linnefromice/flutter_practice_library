import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Practice Library"),
      ),
      body: Center(
        child: Text('Flutter Practice Library')
      ),
    );
  }
}