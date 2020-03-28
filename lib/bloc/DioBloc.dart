import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/User.dart';

class DioBloc {
  final _requestApiController = StreamController<void>();
  Sink<void> get requestApi => _requestApiController.sink;

  final _responseApiController = StreamController<User>();
  Stream<User> get responseApi => _responseApiController.stream;

  DioBloc() {
    _requestApiController.stream.listen((_) {
      _request();
    });
  }

  _request() async {
    final dio = Dio();
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    final User user = User.fromJson(response.data);
    print(user.toJson().toString());
    _responseApiController.sink.add(user);
  }

  void dispose() {
    _requestApiController.close();
    _responseApiController.close();
  }
}