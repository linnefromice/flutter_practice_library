import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';

class DioBloc {
  final _requestApiController = StreamController<void>();
  Sink<void> get requestApi => _requestApiController.sink;

  final _responseApiController = StreamController<Post>();
  Stream<Post> get responseApi => _responseApiController.stream;

  DioBloc() {
    _requestApiController.stream.listen((_) {
      _request();
    });
  }

  _request() async {
    final dio = Dio();
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    final Post post = Post.fromJson(response.data);
    _responseApiController.sink.add(post);
  }

  void dispose() {
    _requestApiController.close();
    _responseApiController.close();
  }
}