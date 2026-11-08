import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iron_track/main.dart';

void main() {
  testWidgets('Iron Track app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(initialThemeMode: ThemeMode.dark));
    expect(find.text('Iron Track'), findsOneWidget);
  });
}
