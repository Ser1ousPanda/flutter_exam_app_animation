import 'dart:ui';

import 'package:flutter/material.dart';

const double cornerRadius = 15.0;
const darkYellow = Color(0xFFFFB900);
const backColor = Color(0xFFFFFFFF);
const List<Color> background = <Color>[
  Color.fromRGBO(170, 207, 21, 1.0),
  Color.fromRGBO(10, 142, 15, 1.0),
];

const List<Color> buttonBackground = <Color>[
  Color.fromRGBO(255, 92, 147, 1.0),
  Color.fromRGBO(115, 82, 135, 1.0)
];
final appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: darkYellow,
  textTheme: TextTheme(
    display1: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
  ),
);
