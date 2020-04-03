import 'package:flutter/material.dart';
import 'package:flutter_practice_library/bloc/DioBloc.dart';
import 'package:provider/provider.dart';

class PracticeDioAndFutureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DioBloc>(
      create: (context) => DioBloc(), // not use (dummy setting)
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
        title: Text('Practice - dio and FutureBuilder'),
      ),
      body: Center(
        child: Text('Practice - dio and FutureBuilder'),
      ),
    );
  }
}