import 'package:flutter/material.dart';
import 'package:flutter_practice_library/bloc/practice/PracticeBlocOne.dart';
import 'package:provider/provider.dart';

class PracticeBlocAndStatefulWidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<PracticeOneBloc>(
      create: (context) => PracticeOneBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: _Screen(),
    );
  }
}

class _Screen extends StatefulWidget {
  @override
  State createState() => _State();
}

class _State extends State<_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PracticeBlocAndStatefulWidgetScreen'),
      ),
      body: Center(
        child: Text('PracticeBlocAndStatefulWidgetScreen'),
      ),
    );
  }
}