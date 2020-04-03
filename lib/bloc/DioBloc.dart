import 'dart:async';

import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';
import 'package:flutter_practice_library/service/JsonplaceholderService.dart';

class DioBloc {
  String _inputedId;

  final _requestApiController = StreamController<String>();
  Sink<String> get requestApi => _requestApiController.sink;

  final _responseApiController = StreamController<List<dynamic>>();
  Stream<List<dynamic>> get responseApi => _responseApiController.stream;

  final _inputedIdController = StreamController<String>();
  Sink<String> get inputId => _inputedIdController.sink;

  DioBloc() {
    _requestApiController.stream.listen((val) {
      _request(val);
    });
    _inputedId = '';
    _inputedIdController.stream.listen((val) {
      _inputedId = val;
    });
  }

  _request(final String value) async {
    print(value);
    List<dynamic> datas;
    if (value == 'posts') {
      datas = await JsonplaceholderService.findPosts();
    } else if (value == 'comments') {
      datas = await JsonplaceholderService.findComments();
    } else if (value == 'albums') {
      datas = await JsonplaceholderService.findAlbums();
    } else {
      datas = await JsonplaceholderService.findPosts();
    }
    _responseApiController.sink.add(datas);
    /*
    List<Post> posts = [];
    if (_inputedId == '') {
      posts = await JsonplaceholderService.findPosts();
    } else {
      int _id;
      try {
        _id = int.parse(_inputedId);
        posts.add(await JsonplaceholderService.findPostbyId(_id));
      } catch (exception) {
        posts = await JsonplaceholderService.findPosts();
      }
    }
     */
  }

  void dispose() {
    _requestApiController.close();
    _responseApiController.close();
    _inputedIdController.close();
  }
}