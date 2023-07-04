import 'package:flutter/material.dart';

const List<Color> colorList = [
  Color.fromARGB(255, 22, 69, 254),
  Colors.tealAccent,
  Colors.yellowAccent,
  Colors.deepPurple,
  Colors.pinkAccent,
  Color.fromARGB(255, 0, 149, 255),
];

class MainTheme {
  final int selectedColor;

  MainTheme({
    this.selectedColor = 0,
  })  : assert(selectedColor >= 0, 'El color debe ser mayor o igual a 0'),
        assert(selectedColor < colorList.length,
            'El color debe ser menor que ${colorList.length}');

  ThemeData getTheme(bool darkMode) => ThemeData(
        brightness: darkMode ? Brightness.dark : Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: colorList[selectedColor],
        appBarTheme: const AppBarTheme(
          centerTitle: false,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: darkMode ? Colors.white : Colors.black),
          headlineLarge:
              TextStyle(color: darkMode ? Colors.white : Colors.black),
        ),
      );
}
