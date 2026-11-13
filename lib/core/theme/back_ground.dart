import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';

/// Animated background wrapper that smoothly transitions theme background colors across light and dark modes.
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
        Positioned.fill(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            color: glass.backGround,
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}
