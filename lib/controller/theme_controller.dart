import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    log(isDarkMode.value ? 'dark' : 'light');
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  final ThemeData lightTheme = ThemeData(splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
      splashColor: Colors.red,
      buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      tabBarTheme: const TabBarTheme(
          indicatorColor: CupertinoColors.activeBlue,
          labelColor: CupertinoColors.activeBlue),
      appBarTheme:
          AppBarTheme(backgroundColor: CupertinoColors.white.withOpacity(.3)));

  final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      tabBarTheme: const TabBarTheme(
          indicatorColor: CupertinoColors.activeBlue,
          labelColor: CupertinoColors.activeBlue),
      appBarTheme:
          AppBarTheme(backgroundColor: CupertinoColors.black.withOpacity(.3)));
}
