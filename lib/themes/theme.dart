import 'package:flutter/material.dart';

final ThemeData pinkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
  scaffoldBackgroundColor: Colors.pink.shade50,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.pink,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.pink,
    foregroundColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.pink.shade100,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  ),
  useMaterial3: true,
);
