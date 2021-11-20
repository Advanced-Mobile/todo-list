import 'package:flutter/material.dart';
import 'package:todo_list/widgets/CustomDialogBox.dart';

import '../models/Todo.dart';

class TodoDetailDialog extends StatelessWidget {

  final Todo todo;
  const TodoDetailDialog({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialogBox(child: AddBox(todo: todo,));
  }
}
