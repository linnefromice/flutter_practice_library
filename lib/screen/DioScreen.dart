import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_library/bloc/DioBloc.dart';
import 'package:provider/provider.dart';

class DioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DioBloc>(
      create: (context) => DioBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: _Screen(),
    );
  }
}

class _Screen extends StatelessWidget {
  _request() async {
    final dio = Dio();
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Practice - dio')
      ),
      body: Center(
          child: RaisedButton(
            child: Text('REQUEST'),
            onPressed: _request,
          )
      ),
    );
  }
}