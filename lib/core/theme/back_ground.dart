import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';

class CustomGlassBackground extends StatelessWidget {
  final Widget child;

  const CustomGlassBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;

    return Stack(
      children: [
        // Background
        Positioned.fill(
          child: Container(
            color: glass.backGround,
          ),
        ),

        // Page content
        Positioned.fill(child: child),
      ],
    );
  }
}