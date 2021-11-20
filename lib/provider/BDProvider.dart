import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:todo_list/models/Todo.dart';

import '../data/database/DBHelper.dart';

class DataProvider with ChangeNotifier {
  final DBHelper? dbHelper;
  List<Todo> _items = [];
  final tableName = 'todo';

  DataProvider(this._items, this.dbHelper) {
    fetchAndSetData();
  }

  List<Todo> get items => [..._items];

  void addTodo(Todo todo) {
    if (dbHelper?.db != null) {
      // do not execute if db is not instantiate
      _items.add(todo);
      notifyListeners();
      dbHelper?.insert(tableName, {
        "id": todo.id,
        'title': todo.title,
        "dateTime": todo.dateTime.millisecondsSinceEpoch,
        "tasks": json.encode(todo.tasksToJson()),
        "note": todo.note,
        "done": todo.done ? 1 : 0,
        "star": todo.star ? 1 : 0,
      });
    }
  }

  void updateTodo(Todo todo) {
    if (dbHelper?.db != null) {
      // do not execute if db is not instantiate
      final index = _items.indexWhere((element) => element.id == todo.id);
      if (index != -1) {
        _items[index].tasks = todo.tasks;
        _items[index].dateTime = todo.dateTime;
        _items[index].title = todo.title;
        _items[index].done = todo.done;
        _items[index].star = todo.star;
        _items[index].note = todo.note;
        notifyListeners();
        dbHelper?.update(tableName, {
          'title': todo.title,
          "dateTime": todo.dateTime.millisecondsSinceEpoch,
          "tasks": json.encode(todo.tasksToJson()),
          "note": todo.note,
          "done": todo.done ? 1 : 0,
          "star": todo.star ? 1 : 0,
        }, todo.id);
      }
    }
  }
  
  void removeTodo(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    dbHelper?.delete(tableName, id);
  }

  Future<void> fetchAndSetData() async {
    if (dbHelper?.db != null) {
      // do not execute if db is not instantiate
      final dataList = await dbHelper?.getData(tableName);
      if (dataList != null) {
        print(dataList[0]);
        _items = dataList
            .map<Todo>(
                (item) => Todo.fromJson(item)).toList();
        notifyListeners();
      }
    }
  }
}
