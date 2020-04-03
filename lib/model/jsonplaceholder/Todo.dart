// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory Todo.fromRawJson(String str) => Todo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}
