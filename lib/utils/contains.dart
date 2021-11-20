import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

const COLOR_BLACK = Color.fromRGBO(48, 47, 48, 1);
const COLOR_GRAY = Color.fromRGBO(141, 141, 141, 1);

const COLOR_WHITE = Colors.white;
const COLOR_DARK_BLUE = Color.fromRGBO(20, 25, 45, 1);

const TextTheme TEXT_THEME_DEFAULT = TextTheme(
  headline1: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 26),
  headline2: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
  headline3: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
  headline4: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 16),
  headline5: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
  headline6: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
  bodyText1: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5),
  bodyText2: TextStyle(color: COLOR_GRAY, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5),
  subtitle1: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w400, fontSize: 12),
  subtitle2: TextStyle(color: COLOR_GRAY, fontWeight: FontWeight.w400, fontSize: 12),
);

const TextTheme TEXT_THEME_SMALL = TextTheme(
  headline1: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
  headline2: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
  headline3: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 18),
  headline4: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
  headline5: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
  headline6: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 10),
  bodyText1: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w500, fontSize: 12, height: 1.5),
  bodyText2: TextStyle(color: COLOR_GRAY, fontWeight: FontWeight.w500, fontSize: 12, height: 1.5),
  subtitle1: TextStyle(color: COLOR_BLACK, fontWeight: FontWeight.w400, fontSize: 10),
  subtitle2: TextStyle(color: COLOR_GRAY, fontWeight: FontWeight.w400, fontSize: 10),
);

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) =>  random.nextInt(255));
  return base64UrlEncode(values);
}

int generateId(String str) {
  final list = str.codeUnits;
  var value = 0;
  for(int i = 0; i < list.length; i++) {
    value = value + list[i];
  }
  return value;
}
