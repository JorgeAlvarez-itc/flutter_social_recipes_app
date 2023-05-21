import 'package:flutter/material.dart';

class Themes{
  final lightTheme=ThemeData().copyWith(
    primaryColor: Colors.orangeAccent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      centerTitle: true,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.black
        )
      )
    )
  );
  final darkTheme=ThemeData().copyWith(
    primaryColor: Colors.deepOrangeAccent,
    appBarTheme: const AppBarTheme(
      brightness: Brightness.dark,
      backgroundColor: Colors.black12,
      centerTitle: true,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white
        )
      )
    )
  );
}