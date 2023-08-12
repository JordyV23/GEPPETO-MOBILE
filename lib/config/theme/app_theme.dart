import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Color(0xFFD33232),
  Color(0xFFD9D9D9),
  Colors.white,
  Colors.red,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 8})
      : assert(selectedColor > 0, 'El color debe de ser mayor a 0'),
        assert(selectedColor < colorList.length,
            'El color debe de ser igual o mayot a ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: colorList[selectedColor+1],
      textTheme: Typography.whiteMountainView,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: colorList[selectedColor],
          secondary: Colors.white,
          tertiary: Colors.black),
      appBarTheme: const AppBarTheme(
          centerTitle: true, backgroundColor: Color(0xFFD33232),shadowColor: Colors.black ));
}
