import 'package:flutter/material.dart';
import 'package:iron_track/core/constants/app_theme_extension.dart';
import 'package:iron_track/core/theme/theme_controller.dart';

import 'app_text_styles.dart';

/// Extension on [BuildContext] to access theme, typography, and controller instances cleanly.
extension ThemeContext on BuildContext {
  /// Access current [GlassTheme] extension tokens.
  GlassTheme get glass =>
      Theme.of(this).extension<GlassTheme>() ?? GlassTheme.light;

  /// Whether current active theme is dark mode.
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  /// Access centralized [AppTextStyles] instance bound to current [glass] theme.
  AppTextStyles get text => AppTextStyles(glass);

  /// Access current [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Access [ThemeController] from scope.
  ThemeController get themeController => ThemeControllerScope.of(this);

  /// Convenient helper to toggle between light and dark theme mode.
  void toggleTheme() => themeController.toggle();
}
