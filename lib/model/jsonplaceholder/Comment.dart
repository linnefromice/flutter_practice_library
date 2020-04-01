// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    postId: json["postId"],
    id: json["id"],
    name: json["name"],
    email: json["email"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "id": id,
    "name": name,
    "email": email,
    "body": body,
  };
}