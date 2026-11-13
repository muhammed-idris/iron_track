import 'package:flutter/material.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'app_theme_extension.dart';

/// App ThemeData configuration for Light and Dark modes.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _buildTheme(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.accent,
          surface: Colors.transparent,
          error: AppColor.danger,
        ),
        glass: GlassTheme.light,
        appBarForeground: AppColor.black,
        dividerColor: AppColor.grey400,
        cardColor: AppColor.white,
        navUnselectedColor: AppColor.grey700,
      );

  static ThemeData get darkTheme => _buildTheme(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: AppColor.primary,
          secondary: AppColor.accent,
          surface: Colors.transparent,
          error: AppColor.danger,
        ),
        glass: GlassTheme.dark,
        appBarForeground: AppColor.white,
        dividerColor: GridColor.grey800,
        cardColor: AppColor.black,
        navUnselectedColor: AppColor.grey800,
      );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required GlassTheme glass,
    required Color appBarForeground,
    required Color dividerColor,
    required Color cardColor,
    required Color navUnselectedColor,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: colorScheme,
      splashFactory: InkRipple.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: appBarForeground,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        fillColor: AppColor.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColor.primary,
            width: 2,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: dividerColor,
        thickness: 1,
      ),
      extensions: [glass],
    );
  }
}
