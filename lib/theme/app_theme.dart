import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF021F2A);
  static const Color backgroundDeep = Color(0xFF011821);
  static const Color surface = Color(0xFF0B3240);
  static const Color surfaceStrong = Color(0xFF123D4D);
  static const Color border = Color(0xFF315665);
  static const Color primary = Color(0xFF18D5D0);
  static const Color primaryText = Color(0xFFEAF7F8);
  static const Color mutedText = Color(0xFF9AB0BA);
  static const Color operational = Color(0xFF24C78E);
  static const Color maintenance = Color(0xFFF1B83B);
  static const Color stopped = Color(0xFFFF5A5F);

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
      primary: primary,
      surface: surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: colorScheme,
      fontFamily: 'Arial',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: primaryText,
          fontSize: 56,
          height: 1,
          fontWeight: FontWeight.w800,
        ),
        headlineSmall: TextStyle(
          color: primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          color: mutedText,
          fontSize: 14,
          height: 1.45,
        ),
        labelMedium: TextStyle(
          color: mutedText,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: backgroundDeep.withValues(alpha: 0.35),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: border.withValues(alpha: 0.7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: border.withValues(alpha: 0.7)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: primary, width: 1.2),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(color: primaryText, fontSize: 14),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: backgroundDeep.withValues(alpha: 0.45),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }
}
