import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get theme => _theme();

  static ThemeData _theme() => ThemeData(
      colorScheme: const ColorScheme.dark().copyWith(
        tertiaryContainer: Colors.deepOrange,
      ),
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 19, 19, 19),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 19, 19, 19),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 195, 65, 25),
          textStyle: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              45.0,
            ), // Set the circular border radius here
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ));
}
