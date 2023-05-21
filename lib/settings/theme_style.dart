import 'package:flutter/material.dart';

class Themes{
  final lightTheme=ThemeData.light().copyWith(
    primaryColor: Colors.orangeAccent,
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.black),
      actionsIconTheme: IconThemeData(
        color: Colors.black
      ),
      iconTheme: IconThemeData(
        color: Colors.black
      )
    )
  );
  final darkTheme=ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    backgroundColor: Colors.black,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white
      ),
      
    ),
    cardTheme: CardTheme(
      color: Colors.black
    ),
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