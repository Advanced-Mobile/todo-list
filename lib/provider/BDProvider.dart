import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:todo_list/models/Todo.dart';

import '../data/database/DBHelper.dart';
import '../models/Task.dart';

class DataProvider with ChangeNotifier {
  final DBHelper? dbHelper;
  List<dynamic> _items = [];
  final tableName = 'todo';

  DataProvider(this._items, this.dbHelper) {
    fetchAndSetData();
  }

  List<Todo> get items => [..._items];

  void addTodo(String title, DateTime dateTime, List<Task> tasks) {
    if (dbHelper?.db != null) {
      // do not execute if db is not instantiate
      final newTodo = Todo(
        title: title,
        dateTime: dateTime,
        tasks: tasks,
      );
      _items.add(newTodo);
      notifyListeners();
      dbHelper?.insert(tableName, {
        'title': newTodo.title,
        "dateTime": newTodo.dateTime,
        "tasks": json.encode(newTodo.tasksToJson()),
        "note": newTodo.note,
        "done": newTodo.done ? 1 : 0,
        "star": newTodo.star ? 1 : 0,
      });
    }
  }

  Future<void> fetchAndSetData() async {
    if (dbHelper?.db != null) {
      // do not execute if db is not instantiate
      final dataList = await dbHelper?.getData(tableName);
      if (dataList != null) {
        _items = dataList
            .map(
              (item) => Todo(
                  title: item['title'],
                  dateTime: item['dateTime'],
                  tasks: json.decode(item['tasks'])['task'],
                  note: item['note'],
                  done: item['done'] == 1 ? true : false,
                  star: item['star'] == 1 ? true : false),
            )
            .toList();
        notifyListeners();
      }
    }
  }
}
