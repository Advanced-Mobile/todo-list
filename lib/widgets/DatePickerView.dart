import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/widgets/CustomTextField.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePickerView extends StatefulWidget {

  final void Function(DateTime)? callback;
  final DateTime dateTime;
  const DatePickerView({Key? key, this.callback, required this.dateTime}) : super(key: key);

  @override
  _DatePickerViewState createState() => _DatePickerViewState();
}

class _DatePickerViewState extends State<DatePickerView> {

  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = widget.dateTime!;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      readOnly: true,
      text: "${DateFormat.yMMMMd('en_US').format(dateTime)}",
      leftIcon: IconButton(
        icon: Icon(
          Icons.date_range_outlined,
        ),
        onPressed: () {},
      ),
      onTap: () {
        DatePicker.showDateTimePicker(context, showTitleActions: true,
            onChanged: (date) {
          print(
            'change $date in time zone ' +
                date.timeZoneOffset.inHours.toString(),
          );
        }, onConfirm: (date) {
          print('confirm $date');
          if (widget.callback != null) {
            widget.callback!(date);
          }
          setState(() {
            dateTime = date;
          });
        },
            minTime: DateTime.now(),
            currentTime: dateTime,
            locale: LocaleType.vi);
      }, rightIcon: Container(),
    );
  }
}
