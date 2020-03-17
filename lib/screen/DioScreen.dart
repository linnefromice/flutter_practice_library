import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioScreen extends StatelessWidget {

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