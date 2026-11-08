import 'package:flutter/material.dart';
import 'package:iron_track/core/constants/app_theme_extension.dart';
import 'package:iron_track/core/theme/app_text_styles.dart';
import 'package:iron_track/core/theme/theme_controller.dart';

extension ThemeContext on BuildContext {
  GlassTheme get glass =>
      Theme.of(this).extension<GlassTheme>() ?? GlassTheme.dark;

  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  AppTextStyles get text => AppTextStyles(glass);

  ThemeController get themeController => ThemeControllerScope.of(this);

  void toggleTheme() => themeController.toggle();
}
