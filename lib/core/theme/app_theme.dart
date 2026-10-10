import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF323232);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF70747D);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,

      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
      ),

      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: darkText,
        ),
        bodyMedium: TextStyle(
          color: darkText,
        ),
      ),


      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}