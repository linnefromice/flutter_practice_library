import 'package:dio/dio.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Album.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Comment.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';

class JsonplaceholderService {
  static final _dio = Dio();
  static final _url = 'https://jsonplaceholder.typicode.com';

  static Future<List<Post>> findPosts() async {
    final Response response = await _dio.get(_url + "/posts");
    List<Post> posts = [];
    response.data.forEach((v) => posts.add(Post.fromJson(v)));
    return posts;
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
    List<Comment> comments = [];
    response.data.forEach((v) => comments.add(Comment.fromJson(v)));
    return comments;
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
    List<Album> albums = [];
    response.data.forEach((v) => albums.add(Album.fromJson(v)));
    return albums;
  }

  static Future<Album> findAlbumbyId(final int id) async {
    final Response response = await _dio.get(_url + '/albums/' + id.toString());
    if (response.data == null) {
      return null;
    } else {
      return Album.fromJson(response.data);
    }
  }

}