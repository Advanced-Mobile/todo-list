import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/src/provider.dart';
import 'package:todo_list/utils/widget_functions.dart';
import 'package:todo_list/widgets/CustomTextButton.dart';
import 'package:todo_list/widgets/CustomTextField.dart';

import '../data/api/notification_api.dart';
import '../models/Task.dart';
import '../models/Todo.dart';
import '../provider/BDProvider.dart';
import '../utils/contains.dart';
import 'DatePickerView.dart';

class CustomDialogBox extends StatelessWidget {
  final Widget child;

  const CustomDialogBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double padding = 25;
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: child);
  }
}

class AddBox extends StatefulWidget {
  final String? task;
  final Todo? todo;

  const AddBox({Key? key, this.task, this.todo}) : super(key: key);

  @override
  _AddBoxState createState() => _AddBoxState();
}

class _AddBoxState extends State<AddBox> {
  TextEditingController _addStepController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  List<TextEditingController> _stepsController = [];
  late String title;
  late final defaultTile;
  late DateTime dateTime = DateTime.now();
  late final List<Task> steps;
  late final List<String> defaultTextListSteps;

  @override
  void initState() {
    super.initState();
    if (widget.todo == null) {
      steps = [];
      defaultTextListSteps = [];
      defaultTile = widget.task!;
      title = widget.task!;
      _titleController.text = widget.task!;
    } else {
      steps = widget.todo!.tasks;
      defaultTextListSteps = [];
      for (int i = 0; i < widget.todo!.tasks.length; i++) {
        defaultTextListSteps.add(widget.todo!.tasks[i].task);
        final textEditingController = TextEditingController();
        textEditingController.text = widget.todo!.tasks[i].task;
        _stepsController.add(textEditingController);
      }
      defaultTile = widget.todo!.title;
      title = widget.todo!.title;
      _titleController.text = widget.todo!.title;
      dateTime = widget.todo!.dateTime;
      _noteController.text = widget.todo!.note;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double padding = 25;
    final dataProvider = context.watch<DataProvider>();
    return Container(
      width: size.width,
      height: size.height / 2.0,
      child: Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 8,
              lightSource: LightSource.topLeft,
              color: COLOR_WHITE),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      addVerticalSpace(10),
                      CustomLayoutTitle(
                        title: "Title",
                      ),
                      addVerticalSpace(10),
                      CustomTextField(
                        controller: _titleController,
                        onSubmitted: (text) {
                          if (text.length == 0) {
                            title = defaultTile;
                            _titleController.text = title;
                          } else {
                            title = text;
                          }
                        },
                        text: defaultTile,
                        leftIcon: Icon(Icons.title),
                        marginLeft: const EdgeInsets.symmetric(horizontal: 10),
                        rightIcon: Container(),
                      ),
                      addVerticalSpace(10),
                      CustomLayoutTitle(
                        title: "Schedule",
                      ),
                      addVerticalSpace(10),
                      DatePickerView(
                        dateTime: dateTime,
                        callback: (date) {
                          dateTime = date;
                        },
                      ),
                      addVerticalSpace(10),
                      CustomLayoutTitle(
                        title: "Steps",
                      ),
                      addVerticalSpace(10),
                      Column(
                        children: List.generate(
                          steps.length,
                          (index) => Column(
                            children: <Widget>[
                              addVerticalSpace(2),
                              CustomTextField(
                                controller: _stepsController[index],
                                onSubmitted: (text) {
                                  if (text.length == 0) {
                                    steps[0].task = defaultTextListSteps[index];
                                    _stepsController[index].text =
                                        defaultTextListSteps[index];
                                  } else {
                                    steps[0].task = text;
                                  }
                                },
                                lineThrough: steps[index].done,
                                leftIcon: IconButton(
                                  icon: steps[index].done
                                      ? Icon(Icons.check_circle)
                                      : Icon(Icons.radio_button_unchecked),
                                  onPressed: () {
                                    setState(() {
                                      steps[index].done = !steps[index].done;
                                    });
                                  },
                                ),
                                rightIcon: IconButton(
                                  icon: Icon(Icons.close_outlined),
                                  onPressed: () {
                                    setState(() {
                                      _stepsController.removeAt(index);
                                      defaultTextListSteps.removeAt(index);
                                      steps.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                              addVerticalSpace(2),
                            ],
                          ),
                        ),
                      ),
                      addVerticalSpace(10),
                      CustomTextField(
                        text: 'Add new step',
                        controller: _addStepController,
                        onSubmitted: (text) {
                          if (text.length > 0) {
                            setState(() {
                              _addStepController.clear();
                              defaultTextListSteps.add(text);
                              final textEditingController =
                                  TextEditingController();
                              textEditingController.text = text;
                              _stepsController.add(textEditingController);
                              this.steps.add(
                                    Task(task: text),
                                  );
                            });
                          }
                        },
                        leftIcon: Icon(
                          Icons.add,
                        ),
                        marginLeft: EdgeInsets.symmetric(horizontal: 10),
                        rightIcon: Container(),
                      ),
                      widget.todo == null ? Container() : addVerticalSpace(10),
                      widget.todo == null ? Container() : CustomLayoutTitle(
                        title: "Note",
                      ),
                      widget.todo == null ? Container() : addVerticalSpace(10),
                      widget.todo == null ? Container() : Container(
                        height: 200,
                        color: COLOR_GRAY,
                        margin: EdgeInsets.symmetric(horizontal: padding),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _noteController,
                          maxLines: 200 ~/ 20,  // <--- maxLines
                          decoration: InputDecoration(
                            hintText: 'Note',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: COLOR_WHITE,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          style: TextStyle(
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      addVerticalSpace(padding),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(padding),
              widget.todo == null
                  ? Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomTextButton(
                            color: COLOR_WHITE,
                            text: "Cancel",
                            textAction: () => Navigator.of(context).pop(),
                          ),
                          addHorizontalSpace(10),
                          CustomTextButton(
                            color: COLOR_WHITE,
                            text: "Save",
                            textAction: () {
                              final todo = Todo(
                                  id: getRandString(25),
                                  title: title,
                                  dateTime: dateTime,
                                  tasks: steps);
                              final timeToNotification = minusMinute(todo.dateTime, 10);
                              print(timeToNotification);
                              final time = NotificationApi.getDateTimeTz(timeToNotification);
                              print(time);
                              NotificationApi.showNotificationWithSchedule(
                                id: generateId(todo.id),
                                title: todo.title,
                                body: todo.note,
                                payload: todo.id,
                                scheduledDate: time,
                              );
                              dataProvider.addTodo(todo);
                              Navigator.of(context).pop();
                            },
                          ),
                          addHorizontalSpace(padding),
                        ],
                      ),
                    )
                  : Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomTextButton(
                            color: COLOR_WHITE,
                            text: "Cancel",
                            textAction: () => Navigator.of(context).pop(),
                          ),
                          addHorizontalSpace(10),
                          CustomTextButton(
                            color: COLOR_WHITE,
                            text: "Update",
                            textAction: () {
                              final todo = widget.todo!;
                              todo.tasks = steps;
                              todo.title = title;
                              todo.dateTime = dateTime;
                              todo.note = _noteController.text;
                              NotificationApi.removeNotification(generateId(widget.todo!.id));
                              final timeToNotification = minusMinute(todo.dateTime, 10);
                              final time = NotificationApi.getDateTimeTz(timeToNotification);
                              NotificationApi.showNotificationWithSchedule(
                                id: generateId(todo.id),
                                title: todo.title,
                                body: todo.note,
                                payload: todo.id,
                                scheduledDate: time,
                              );
                              dataProvider.updateTodo(todo);
                              Navigator.of(context).pop();
                            },
                          ),
                          addHorizontalSpace(10),
                          CustomTextButton(
                            color: COLOR_WHITE,
                            text: "Delete",
                            textAction: () {
                              NotificationApi.removeNotification(generateId(widget.todo!.id));
                              dataProvider.removeTodo(widget.todo!.id);
                              Navigator.of(context).pop();
                            },
                          ),
                          addHorizontalSpace(padding),
                        ],
                      ),
                    ),
              addVerticalSpace(padding),
            ],
          )),
    );
  }

  @override
  void dispose() {
    _addStepController.dispose();
    _titleController.dispose();
    _noteController.dispose();
    for (int i = 0; i < _stepsController.length; i++) {
      _stepsController[i].dispose();
    }
    super.dispose();
  }

  DateTime minusMinute(DateTime dateTime, int value) {
    final mFirst = dateTime.millisecondsSinceEpoch;
    final mSecond = value * 60 * 1000;
    return (DateTime.fromMillisecondsSinceEpoch(mFirst - mSecond));
  }
}

class CustomLayoutTitle extends StatelessWidget {
  final String title;

  const CustomLayoutTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double padding = 25;
    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: NeumorphicText(
        title,
        style: NeumorphicStyle(
            depth: 4, //customize depth here
            color: COLOR_BLACK, //customize color here
            border: NeumorphicBorder(
              isEnabled: true,
              color: COLOR_BLACK,
              width: 2,
            )),
        textStyle: NeumorphicTextStyle(
          fontSize: 18, //customize size here
          // AND others usual text style properties (fontFamily, fontWeight, ...)
        ),
      ),
    );
  }
}
