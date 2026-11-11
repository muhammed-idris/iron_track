import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iron_track/core/constants/app_theme.dart';
import 'package:iron_track/core/theme/back_ground.dart';
import 'package:iron_track/core/theme/theme_controller.dart';
import 'package:iron_track/features/home/widgets/next_workout_widget.dart';
import 'package:iron_track/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  final initialThemeMode = await ThemeController.loadInitialMode();

  runApp(
    MyApp(initialThemeMode: initialThemeMode),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialThemeMode});

  final ThemeMode initialThemeMode;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ThemeController _themeController;

  @override
  void initState() {
    super.initState();
    _themeController = ThemeController(initialMode: widget.initialThemeMode);
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeControllerScope(
      controller: _themeController,
      child: ListenableBuilder(
        listenable: _themeController,
        builder: (context, _) {
          final isDark = _themeController.isDark;

          return MaterialApp(
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              scrollbars: false,
            ),
            title: 'Iron Track',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: _themeController.themeMode,
            navigatorObservers: [routeObserver],
            home: const SplashScreen(),
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness:
                      isDark ? Brightness.light : Brightness.dark,
                  statusBarBrightness:
                      isDark ? Brightness.dark : Brightness.light,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness:
                      isDark ? Brightness.light : Brightness.dark,
                ),
                child: CustomGlassBackground(
                  child: child ?? const SizedBox.shrink(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
