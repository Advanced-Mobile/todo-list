import 'dart:convert';
import 'dart:math';

import 'Task.dart';

class Todo {
  String title;
  List<Task> tasks;
  DateTime dateTime;
  String note;
  bool done;
  bool star;
  String id;

  Todo(
      {required this.title,
      required this.dateTime,
      required this.tasks,
      this.note = "",
      this.done = false,
      this.star = false,
      dataTime,
      required this.id});

  Map<String, dynamic> toJson() => {
        "title": title,
        "tasks": List<dynamic>.from(
          tasks.map(
            (x) => x.toJson(),
          ),
        ),
        "dateTime": dateTime,
        "note": note,
        "done": done,
        "star": star
      };

  Map<String, dynamic> tasksToJson() => {
        "tasks": List<dynamic>.from(
          tasks.map(
            (x) => x.toJson(),
          ),
        ),
      };

  factory Todo.fromJson(Map<String, dynamic> jsonData) => Todo(
        id: jsonData["id"],
        title: jsonData["title"],
        tasks: List<Task>.from(
          json.decode(jsonData["tasks"])["tasks"].map(
                (x) => Task.fromJson(x),
              ),
        ),
        dateTime: DateTime.fromMillisecondsSinceEpoch(jsonData["dateTime"]),
        note: jsonData["note"],
        done: jsonData["done"] == 1,
        star: jsonData["star"] == 1,
      );
}
