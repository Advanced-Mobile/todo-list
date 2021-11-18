import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/BDProvider.dart';
import 'package:todo_list/utils/contains.dart';
import 'package:todo_list/widgets/BottomBar.dart';

import 'data/database/DBHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWeight = window.physicalSize.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DBHelper()),
        ChangeNotifierProxyProvider<DBHelper, DataProvider>(
          create: (context) => DataProvider([], null),
          update: (context, db, previous) =>
              DataProvider(previous == null ? [] : previous.items, db),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO LIST',
        theme: ThemeData(
            primaryColor: COLOR_WHITE,
            textTheme:
                screenWeight < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
            fontFamily: 'Montserrat', colorScheme: ColorScheme.fromSwatch().copyWith(secondary: COLOR_DARK_BLUE)),
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
      ),
    );
  }
}
