import 'package:flutter/material.dart';
import 'package:todo_list/utils/contains.dart';

class BorderBox extends StatelessWidget {

  final Widget child;
  final EdgeInsets? padding;
  final double width, height;
  final void Function()? onTap;

  const BorderBox({Key? key,
    required this.child,
    this.padding,
    required this.width,
    required this.height,
    this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: COLOR_WHITE,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: COLOR_GRAY.withAlpha(40), width: 2)
        ),
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Center(child: child,),
      ),
    );
  }
}
