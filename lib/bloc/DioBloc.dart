import 'dart:async';

import 'package:flutter_practice_library/model/jsonplaceholder/Album.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Comment.dart';
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
    print(_inputedId);
    List<dynamic> datas = [];
    if (value == 'posts') {
      if (_inputedId == '') {
        datas = await JsonplaceholderService.findPosts();
      } else {
        int _id;
        try {
          _id = int.parse(_inputedId);
          List<Post> dtos = [await JsonplaceholderService.findPostbyId(_id)];
          datas = dtos;
        } catch (exception) {
          print(exception.toString());
          datas = await JsonplaceholderService.findPosts();
        }
      }
    } else if (value == 'comments') {
      if (_inputedId == '') {
        datas = await JsonplaceholderService.findComments();
      } else {
        int _id;
        try {
          _id = int.parse(_inputedId);
          List<Comment> dtos = [await JsonplaceholderService.findCommentbyId(_id)];
          datas = dtos;
        } catch (exception) {
          print(exception.toString());
          datas = await JsonplaceholderService.findComments();
        }
      }
    } else if (value == 'albums') {
      if (_inputedId == '') {
        datas = await JsonplaceholderService.findAlbums();
      } else {
        int _id;
        try {
          _id = int.parse(_inputedId);
          List<Album> dtos = [await JsonplaceholderService.findAlbumbyId(_id)];
          datas = dtos;
        } catch (exception) {
          print(exception.toString());
          datas = await JsonplaceholderService.findAlbums();
        }
      }
    } else {
      if (_inputedId == '') {
        datas = await JsonplaceholderService.findPosts();
      } else {
        int _id;
        try {
          _id = int.parse(_inputedId);
          datas.add(await JsonplaceholderService.findPostbyId(_id));
        } catch (exception) {
          datas = await JsonplaceholderService.findPosts();
        }
      }
    }
    _responseApiController.sink.add(datas);
  }

  void dispose() {
    _requestApiController.close();
    _responseApiController.close();
    _inputedIdController.close();
  }
}