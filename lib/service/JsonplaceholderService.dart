import 'package:dio/dio.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Album.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Comment.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Photo.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Todo.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/User.dart';

class JsonplaceholderService {
  static final _dio = Dio();
  static final _url = 'https://jsonplaceholder.typicode.com';

  static Future<List<Post>> findPosts() async {
    final Response response = await _dio.get(_url + "/posts");
    List<Post> domains = [];
    response.data.forEach((v) => domains.add(Post.fromJson(v)));
    return domains;
  }

  static Future<Post> findPostbyId(final int id) async {
    final Response response = await _dio.get(_url + '/posts/' + id.toString());
    if (response.data == null) {
      return null;
    } else {
      return Post.fromJson(response.data);
    }
  }

  static Future<List<Comment>> findComments() async {
    final Response response = await _dio.get(_url + "/comments");
    List<Comment> domains = [];
    response.data.forEach((v) => domains.add(Comment.fromJson(v)));
    return domains;
  }

  static Future<Comment> findCommentbyId(final int id) async {
    final Response response = await _dio.get(_url + '/comments/' + id.toString());
    if (response.data == null) {
      return null;
    } else {
      return Comment.fromJson(response.data);
    }
  }

  static Future<List<Album>> findAlbums() async {
    final Response response = await _dio.get(_url + "/albums");
    List<Album> domains = [];
    response.data.forEach((v) => domains.add(Album.fromJson(v)));
    return domains;
  }

  static Future<Album> findAlbumbyId(final int id) async {
    final Response response = await _dio.get(_url + '/albums/' + id.toString());
    if (response.data == null) {
      return null;
    } else {
      return Album.fromJson(response.data);
    }
  }

  static Future<List<Photo>> findPhotos() async {
    final Response response = await _dio.get(_url + "/photos");
    List<Photo> domains = [];
    response.data.forEach((v) => domains.add(Photo.fromJson(v)));
    return domains;
  }

  static Future<Photo> findPhotobyId(final int id) async {
    final Response response = await _dio.get(_url + '/photos/' + id.toString());
    if (response.data == null) {
      return null;
    } else {
      return Photo.fromJson(response.data);
    }
  }

  static Future<List<Todo>> findTodos() async {
    final Response response = await _dio.get(_url + "/todos");
    List<Todo> domains = [];
    response.data.forEach((v) => domains.add(Todo.fromJson(v)));
    return domains;
  }

  static Future<Todo> findTodobyId(final int id) async {
    final Response response = await _dio.get(_url + '/todos/' + id.toString());
    if (response.data == null) {
      return null;
    } else {
      return Todo.fromJson(response.data);
    }
  }

  static Future<List<User>> findUsers() async {
    final Response response = await _dio.get(_url + "/users");
    List<User> domains = [];
    response.data.forEach((v) => domains.add(User.fromJson(v)));
    return domains;
  }

  static Future<User> findUserbyId(final int id) async {
    final Response response = await _dio.get(_url + '/users/' + id.toString());
    if (response.data == null) {
      return null;
    } else {
      return User.fromJson(response.data);
    }
  }
}