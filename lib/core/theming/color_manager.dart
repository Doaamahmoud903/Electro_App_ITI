import 'package:flutter/material.dart';

class ColorsManager {
  static Color get primary => _isDark ? primaryDark : primaryLight;
  static Color get text => _isDark ? Colors.white : Colors.black;

  static bool _isDark = false;

  static void setThemeMode(bool isDark) {
    _isDark = isDark;
  }

  static Color lightBlue = const Color(0xFF5669FF);
  static Color primaryDark = const Color(0xFF101127);
  static Color primaryLight = const Color(0xFF004288);
  static Color textColor = const Color.fromRGBO(32, 34, 68, 1);
  static Color whiteColor = const Color.fromARGB(255, 255, 255, 255);
  static Color yellowColor = const Color(0xffF0A518);
  static Color greenColor = const Color(0xff038446);
  static Color grayColor = const Color(0xffF0F0F0);
  static Color textColorInTextField = const Color(0xffA7A7A7);
  static Color errorColor = const Color(0xffe61f34);
  static Color arrowListTile = const Color(0xff000C23);
  static Color background = const Color(0xffF2F3F6);
  static Color lightPrimary = const Color.fromARGB(255, 206, 225, 243);

  static Color grey = Colors.grey.shade100;
  static Color grey0 = Colors.grey.shade300;
  static Color grey1 = const Color(0xffb4b4b4);
  static Color grey2 = const Color(0xff9B9B9B);
  static Color grey3 = const Color(0xff707070);
  static Color grey4 = Colors.grey.shade700;
}
