import 'dart:async';

import 'package:dio/dio.dart';

class DioBloc {
  final _requestApiController = StreamController<void>();
  Sink<void> get requestApi => _requestApiController.sink;

  DioBloc() {
    _requestApiController.stream.listen((_) {
      _request();
    });
  }

  _request() async {
    final dio = Dio();
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    print(response.data);
  }

  void dispose() {
    _requestApiController.close();
  }
}