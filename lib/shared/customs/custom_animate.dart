import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension AnimationExtension on Widget {
  Widget slideUp({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCubic,
    double begin = 0.3,
    double end = 0.0,
    Duration? delay,
  }) {
    return animate(delay: delay)
        .slideY(
      begin: begin,
      end: end,
      duration: duration,
      curve: curve,
    )
        .fadeIn(duration: duration);
  }

  Widget slideLeft({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCubic,
    double begin = 0.3,
    double end = 0.0,
    Duration? delay,
  }) {
    return animate(delay: delay)
        .slideX(
      begin: begin,
      end: end,
      duration: duration,
      curve: curve,
    )
        .fadeIn(duration: duration);
  }
  Widget slideDown({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCubic,
    double begin = -0.3,
    double end = 0.0,
    Duration? delay,
  }) {
    return animate(delay: delay)
        .slideY(
      begin: begin,
      end: end,
      duration: duration,
      curve: curve,
    )
        .fadeIn(duration: duration);
  }

  Widget slideRight({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCubic,
    double begin = -0.3,
    double end = 0.0,
    Duration? delay,
  }) {
    return animate(delay: delay)
        .slideX(
      begin: begin,
      end: end,
      duration: duration,
      curve: curve,
    )
        .fadeIn(duration: duration);
  }
}