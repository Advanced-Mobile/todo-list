class Task {
  String task;
  bool done;

  Task({required this.task, this.done = false});

  Map<String, dynamic> toJson() => {"task": task, "done": done};

  factory Task.fromJson(Map<String, dynamic> json) =>
      Task(task: json["task"], done: json["done"]);
}
