import 'package:flutter/material.dart';
import 'package:todo_list/widgets/CustomDialogBox.dart';

class AddDialog extends StatelessWidget {

  final String task;
  const AddDialog({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialogBox(child: AddBox(task: task,));
  }
}
