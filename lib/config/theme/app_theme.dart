import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.pink,
  Colors.purple,
  Colors.orange,
  Colors.cyan,
  Colors.black,
];


class AppTheme {
  final int selectedColor;


  AppTheme({
    this.selectedColor = 8
  }) : assert (
    selectedColor > 0,'El color debe de ser mayor a 0' 
  ), assert(selectedColor<colorList.length, 'El color debe de ser igual o mayot a ${colorList.length-1}');

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList[selectedColor],
    appBarTheme: const AppBarTheme(
      centerTitle: true
    )
  );
}