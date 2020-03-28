import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';

class DioBloc {
  final _requestApiController = StreamController<void>();
  Sink<void> get requestApi => _requestApiController.sink;

  final _responseApiController = StreamController<List<Post>>();
  Stream<List<Post>> get responseApi => _responseApiController.stream;

  DioBloc() {
    _requestApiController.stream.listen((_) {
      _request();
    });
  }

  _request() async {
    final dio = Dio();
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    List<Post> posts = [];
    response.data.forEach((v) => posts.add(Post.fromJson(v)));
    _responseApiController.sink.add(posts);
  }

  void dispose() {
    _requestApiController.close();
    _responseApiController.close();
  }
}