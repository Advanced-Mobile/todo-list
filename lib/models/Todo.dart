import 'Task.dart';

class Todo {
  String title;
  List<Task> tasks;
  DateTime dateTime;
  String note;
  bool done;
  bool star;

  Todo(
      {required this.title,
      required this.dateTime,
      required this.tasks,
      this.note = "",
      this.done = false,
      this.star = false, dataTime});

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

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json["title"],
        tasks: List<Task>.from(
          json["tasks"].map(
            (x) => Task.fromJson(x),
          ),
        ),
        dateTime: json["dateTime"],
        note: json["note"],
        done: json["done"],
        star: json["star"],
      );
}
