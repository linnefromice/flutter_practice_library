import 'package:dio/dio.dart';
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
}