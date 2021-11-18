import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:todo_list/utils/contains.dart';
import 'package:todo_list/widgets/BottomBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWeight = window.physicalSize.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO LIST',
      theme: ThemeData(
          primaryColor: COLOR_WHITE,
          accentColor: COLOR_DARK_BLUE,
          textTheme: screenWeight < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
          fontFamily: 'Montserrat'),
      home: Material(
        child: SafeArea(
          child: Scaffold(
            body: GetMaterialApp(
              navigatorKey: Get.key,
              initialRoute: '/home',
              getPages: [
                GetPage(
                  name: '/home',
                  page: () => Home(),
                  binding: HomeBinding(),
                ),
                GetPage(
                  name: '/search',
                  page: () => Search(),
                  binding: SearchBinding(),
                ),
                GetPage(
                  name: '/setting',
                  page: () => Setting(),
                  binding: SettingBinding(),
                ),
              ],
            ),
            bottomNavigationBar: CustomBottomBar(),
          ),
        ),
      ),
    );
  }
}
