import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const themeModePreferenceKey = 'theme_mode';

class ThemeController extends ChangeNotifier {
  ThemeController({required ThemeMode initialMode}) : _themeMode = initialMode;

  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> toggle() async {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    await _persist();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    await _persist();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeModePreferenceKey, _themeMode.index);
  }

  static Future<ThemeMode> loadInitialMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt(themeModePreferenceKey);
    if (savedIndex != null &&
        savedIndex >= 0 &&
        savedIndex < ThemeMode.values.length) {
      return ThemeMode.values[savedIndex];
    }
    return ThemeMode.light;
  }
}

class ThemeControllerScope extends InheritedNotifier<ThemeController> {
  const ThemeControllerScope({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<ThemeControllerScope>();
    assert(scope != null, 'ThemeControllerScope not found in widget tree');
    return scope!.notifier!;
  }
}
