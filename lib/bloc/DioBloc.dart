import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';

class DioBloc {
  String _inputedId;

  final _requestApiController = StreamController<void>();
  Sink<void> get requestApi => _requestApiController.sink;

  final _responseApiController = StreamController<List<Post>>();
  Stream<List<Post>> get responseApi => _responseApiController.stream;

  final _inputedIdController = StreamController<String>();
  Sink<String> get inputId => _inputedIdController.sink;

  DioBloc() {
    _requestApiController.stream.listen((_) {
      _request();
    });
    _inputedId = '';
    _inputedIdController.stream.listen((val) {
      _inputedId = val;
    });
  }

  _request() async {
    final dio = Dio();
    List<Post> posts = [];
    final url = 'https://jsonplaceholder.typicode.com/posts';
    if (_inputedId == '') {
      Response response = await dio.get(url);
      response.data.forEach((v) => posts.add(Post.fromJson(v)));
    } else {
      Response response = await dio.get(url + '/' + _inputedId);
      posts.add(Post.fromJson(response.data));
    }
    _responseApiController.sink.add(posts);
  }

  void dispose() {
    _requestApiController.close();
    _responseApiController.close();
    _inputedIdController.close();
  }
}