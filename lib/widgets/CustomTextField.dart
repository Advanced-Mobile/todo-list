import 'package:flutter/material.dart';

import '../utils/contains.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final Widget leftIcon;
  final Widget rightIcon;
  final void Function()? onTap;
  final void Function(String)? onChange;
  final void Function(String)? onSubmitted;
  final EdgeInsetsGeometry marginLeft;
  final EdgeInsetsGeometry marginRight;
  final bool readOnly;
  final String? initialText;
  final bool lineThrough;
  final TextEditingController? controller;

  CustomTextField(
      {Key? key,
      this.text = "",
      required this.leftIcon,
      required this.rightIcon,
      this.onTap,
      this.onChange,
      this.onSubmitted,
      this.marginLeft = const EdgeInsets.symmetric(horizontal: 0),
      this.marginRight = const EdgeInsets.symmetric(horizontal: 0),
      this.readOnly = false,
      this.initialText,
      this.lineThrough = false,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: COLOR_GRAY.withOpacity(1)),
          child: Row(
            children: [
              Container(margin: marginLeft, child: leftIcon),
              Expanded(
                child: TextFormField(
                  readOnly: readOnly,
                  controller: controller,
                  onChanged: onChange,
                  onTap: onTap,
                  onFieldSubmitted: onSubmitted,
                  decoration: InputDecoration(
                    hintText: text,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color: COLOR_WHITE,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  initialValue: initialText,
                  style: TextStyle(
                    color: COLOR_WHITE,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    decoration: lineThrough
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              Container(margin: marginRight, child: rightIcon),
            ],
          ),
        ),
      ),
    );
  }
}
