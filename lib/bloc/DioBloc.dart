import 'dart:async';

import 'package:flutter_practice_library/model/jsonplaceholder/Album.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Comment.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Photo.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Todo.dart';
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
      datas = await _requestPost();
    } else if (value == 'comments') {
      datas = await _requestComment();
    } else if (value == 'albums') {
      datas = await _requestAlbum();
    } else if (value == 'photos') {
      datas = await _requestPhoto();
    } else if (value == 'todos') {
      datas = await _requestTodo();
    }
    _responseApiController.sink.add(datas);
  }

  Future<List<Post>> _requestPost() async {
    if (_inputedId == '') {
      return await JsonplaceholderService.findPosts();
    } else {
      int _id;
      try {
        _id = int.parse(_inputedId);
        List<Post> dtos = [await JsonplaceholderService.findPostbyId(_id)];
        return dtos;
      } catch (exception) {
        print(exception.toString());
        return await JsonplaceholderService.findPosts();
      }
    }
  }

  Future<List<Comment>> _requestComment() async {
    if (_inputedId == '') {
      return await JsonplaceholderService.findComments();
    } else {
      int _id;
      try {
        _id = int.parse(_inputedId);
        List<Comment> dtos = [await JsonplaceholderService.findCommentbyId(_id)];
        return dtos;
      } catch (exception) {
        print(exception.toString());
        return await JsonplaceholderService.findComments();
      }
    }
  }

  Future<List<Album>> _requestAlbum() async {
    if (_inputedId == '') {
      return await JsonplaceholderService.findAlbums();
    } else {
      int _id;
      try {
        _id = int.parse(_inputedId);
        List<Album> dtos = [await JsonplaceholderService.findAlbumbyId(_id)];
        return dtos;
      } catch (exception) {
        print(exception.toString());
        return JsonplaceholderService.findAlbums();
      }
    }
  }

  Future<List<Photo>> _requestPhoto() async {
    if (_inputedId == '') {
      return await JsonplaceholderService.findPhotos();
    } else {
      int _id;
      try {
        _id = int.parse(_inputedId);
        List<Photo> dtos = [await JsonplaceholderService.findPhotobyId(_id)];
        return dtos;
      } catch (exception) {
        print(exception.toString());
        return JsonplaceholderService.findPhotos();
      }
    }
  }

  Future<List<Todo>> _requestTodo() async {
    if (_inputedId == '') {
      return await JsonplaceholderService.findTodos();
    } else {
      int _id;
      try {
        _id = int.parse(_inputedId);
        List<Todo> dtos = [await JsonplaceholderService.findTodobyId(_id)];
        return dtos;
      } catch (exception) {
        print(exception.toString());
        return JsonplaceholderService.findTodos();
      }
    }
  }

  void dispose() {
    _requestApiController.close();
    _responseApiController.close();
    _inputedIdController.close();
  }
}