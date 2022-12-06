
import 'package:flutter/material.dart';

class ThemeColors {
  static Color mainText = const  Color.fromRGBO(188, 200, 215, 1.0);
  static Color innerText =  const  Color.fromRGBO(82, 95, 105, 1.0);
  static Color activeMenu = Colors.redAccent;
  static Color mainThemeBackground = const Color.fromRGBO(30,30,38, 1);
  static Color cardBackground = const Color.fromRGBO(40, 41, 49, 1);
}

class GeneralTheme{
  static BorderRadius mainRounding = const BorderRadius.all(Radius.circular(5));
  static EdgeInsets boxPadding = const EdgeInsets.fromLTRB(10, 10, 10, 10);
  static EdgeInsets boxMargin = const EdgeInsets.fromLTRB(5, 5, 5, 5);
  static EdgeInsets rowTopMargin = const EdgeInsets.fromLTRB(0, 5, 0, 0);
  static EdgeInsets rowInnerTopMargin = const EdgeInsets.fromLTRB(0, 10, 0, 0);
}