import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/Todo.dart';
import 'package:todo_list/utils/contains.dart';
import 'package:todo_list/utils/widget_functions.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isChangeIcon = false;
  var opacity = 0.5;
  var actionIndex = 0;
  final List<Todo> todoList = [
    Todo(
        title: "Lorem Ipsum is simply dummy text 1",
        dateTime: DateTime.utc(2021),
    tasks: [],),
    Todo(title: "Lorem Ipsum is simply dummy text 2", dateTime: DateTime.now(), tasks: [],),
    Todo(
        title: "Lorem Ipsum is simply dummy text 3",
        dateTime: DateTime.utc(2021, 12), tasks: [],),
    Todo(title: "Lorem Ipsum is simply dummy text 4", dateTime: DateTime.now(), tasks: [],),
    Todo(
        title: "Lorem Ipsum is simply dummy text 5",
        dateTime: DateTime.now(),
        done: true, tasks: [],),
    Todo(
        title:
            "Lorem Ipsum is simply dummy text Lorem Ipsum is simply dummy text 6",
        dateTime: DateTime.now(), tasks: [],),
    Todo(title: "Lorem Ipsum is simply dummy text 7", dateTime: DateTime.now(), tasks: [],),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    var todoListDoing = todoList.where((element) => !element.done).toList();
    var todoListDone = todoList.where((element) => element.done).toList();
    if (actionIndex == 1) {
      todoListDoing = todoList
          .where(
            (element) =>
                !element.done && element.dateTime.day == DateTime.now().day,
          )
          .toList();
      todoListDone = todoList
          .where(
            (element) =>
                element.done && element.dateTime.day == DateTime.now().day,
          )
          .toList();
    } else if (actionIndex == 2) {
      todoListDoing = todoList
          .where(
            (element) =>
                !element.done &&
                element.dateTime.isAfter(
                  DateTime.now(),
                ),
          )
          .toList();
      todoListDone = todoList
          .where(
            (element) =>
                element.done &&
                element.dateTime.isAfter(
                  DateTime.now(),
                ),
          )
          .toList();
    } else if (actionIndex == 3) {
      todoListDoing = todoList
          .where(
            (element) =>
        !element.done &&
            element.star == true
      )
          .toList();
      todoListDone = todoList
          .where(
            (element) =>
        element.done &&
            element.star == true
      )
          .toList();
    }
    final countDone = todoListDone.length;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 80, top: 90),
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Column(
                    children: List.generate(
                      todoListDoing.length,
                      (index) => TodoItem(
                        itemData: todoListDoing[index],
                        radioAction: () {
                          setState(() {
                            todoListDoing[index].done = true;
                          });
                        },
                        starAction: () {
                          setState(() {
                            todoListDoing[index].star = !todoListDoing[index].star;
                          });
                        },
                      ),
                    ),
                  ),
                  countDone > 0 ? addVerticalSpace(10) : Container(),
                  countDone > 0
                      ? Container(
                          padding: sidePadding,
                          alignment: Alignment.centerLeft,
                          child: NeumorphicText(
                            "Completed",
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
                        )
                      : Container(),
                  countDone > 0 ? addVerticalSpace(10) : Container(),
                  Column(
                    children: List.generate(
                      todoListDone.length,
                      (index) => TodoItem(
                        itemData: todoListDone[index],
                        radioAction: () {
                          setState(() {
                            todoListDone[index].done = false;
                          });
                        },
                        starAction: () {
                          setState(() {
                            todoListDoing[index].star = !todoListDoing[index].star;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: padding,
              right: padding,
              child: Container(
                color: COLOR_WHITE.withOpacity(1),
                width: size.width,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: size.width,
                        child: Text(
                          "Todo List Official",
                          style: TextStyle(
                              color: COLOR_BLACK,
                              fontWeight: FontWeight.w700,
                              fontSize: 22),
                        ),
                      ),
                    ),
                    addVerticalSpace(5),
                    _listTextButton()
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: padding,
              left: padding,
              right: padding,
              child: Container(
                height: 50,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: COLOR_GRAY.withOpacity(opacity)),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            !isChangeIcon
                                ? Icons.add
                                : Icons.radio_button_unchecked,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (text) {
                              if (text.length > 0) {
                                if (!isChangeIcon) {
                                  setState(() {
                                    isChangeIcon = true;
                                  });
                                }
                              } else {
                                if (isChangeIcon) {
                                  setState(() {
                                    isChangeIcon = false;
                                  });
                                }
                              }
                            },
                            onTap: () {
                              setState(() {
                                opacity = 1;
                              });
                            },
                            onSubmitted: (text) {
                              setState(() {
                                opacity = 0.5;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Add a Task",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: COLOR_WHITE,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            style: TextStyle(
                                color: COLOR_WHITE,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTextButton() {
    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _textButton("All", () {
              setState(() {
                actionIndex = 0;
              });
            }, actionIndex == 0 ? true : false),
            addHorizontalSpace(10),
            _textButton("Today", () {
              setState(() {
                actionIndex = 1;
              });
            }, actionIndex == 1 ? true : false),
            addHorizontalSpace(10),
            _textButton("Upcoming", () {
              setState(() {
                actionIndex = 2;
              });
            }, actionIndex == 2 ? true : false),
            addHorizontalSpace(10),
            _textButton("Important", () {
              setState(() {
                actionIndex = 3;
              });
            }, actionIndex == 3 ? true : false),
          ],
        ),
      ),
    );
  }

  Widget _textButton(String text, void Function()? textAction, bool isClicked) {
    return NeumorphicButton(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          depth: 8,
          lightSource: LightSource.topLeft,
          color: isClicked ? Colors.grey : Colors.white),
      onPressed: textAction,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TodoItem extends StatelessWidget {
  final Todo itemData;
  final void Function()? starAction;
  final void Function()? radioAction;

  const TodoItem(
      {Key? key, required this.itemData, this.starAction, this.radioAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double padding = 25;
    final countTasks = itemData.tasks.length;
    final countDoneTasks = itemData.tasks.where((element) => element.done).length;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: padding),
      child: NeumorphicButton(
        onPressed: () {},
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            color: COLOR_WHITE),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: IconButton(
                icon: Icon(
                  itemData.done
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  size: 25.0,
                ),
                onPressed: radioAction,
              ),
            ),
            Expanded(
                child: Column(
              children: <Widget>[
                IntrinsicHeight(
                  child: Text(
                    itemData.title,
                    style: TextStyle(
                      color: COLOR_BLACK,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      decoration: itemData.done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                addVerticalSpace(10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("$countDoneTasks of $countTasks"),
                      addHorizontalSpace(10),
                      Row(
                        children: <Widget>[
                          Icon(Icons.date_range_outlined),
                          addHorizontalSpace(5),
                          Text(
                            "${DateFormat.yMMMMd('en_US').format(itemData.dateTime)}",
                            style: TextStyle(
                                color:
                                    itemData.dateTime.isBefore(DateTime.now())
                                        ? Colors.red
                                        : Colors.green),
                          ),
                        ],
                      ),
                      addHorizontalSpace(10),
                      Row(
                        children: <Widget>[
                          Icon(Icons.note_outlined),
                          addHorizontalSpace(5),
                          Text("Note")
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
            IconButton(
              icon: Icon(
                !itemData.star ? Icons.star_border : Icons.star,
                size: 25.0,
              ),
              onPressed: starAction,
            ),
          ],
        ),
      ),
    );
  }
}
