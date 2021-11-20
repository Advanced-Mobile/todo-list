import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../utils/contains.dart';

class CustomTextButton extends StatelessWidget {
  final Color color;
  final void Function()? textAction;
  final String text;

  const CustomTextButton(
      {Key? key, required this.color, this.textAction, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        depth: 8,
        lightSource: LightSource.topLeft,
        color: color,
      ),
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
}
