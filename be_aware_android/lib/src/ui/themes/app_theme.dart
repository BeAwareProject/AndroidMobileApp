import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get light => _theme(Brightness.light);
  static ThemeData get dark => _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) => ThemeData(
        brightness: brightness,
        colorScheme: brightness == Brightness.light
            ? const ColorScheme.light().copyWith(
                primary: Colors.lightBlue,
              )
            : const ColorScheme.dark().copyWith(
                primary: Colors.blue,
              ),
      );
}
