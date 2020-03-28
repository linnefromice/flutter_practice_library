import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';
import 'package:flutter_practice_library/service/jsonplaceholder/PostService.dart';

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
    List<Post> posts = [];
    if (_inputedId == '') {
      posts = await PostService.findPosts();
    } else {
      int _id;
      try {
        _id = int.parse(_inputedId);
        posts.add(await PostService.findPostbyId(_id));
      } catch (exception) {
        posts = await PostService.findPosts();
      }
    }
    _responseApiController.sink.add(posts);
  }

  void dispose() {
    _requestApiController.close();
    _responseApiController.close();
    _inputedIdController.close();
  }
}