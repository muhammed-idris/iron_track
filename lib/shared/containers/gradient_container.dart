import 'package:flutter/material.dart';

/// Reusable Gradient Container for styled cards and background surfaces.
class GradientContainer extends StatelessWidget {
  final Widget? child;
  final List<Color> colors;
  final double borderRadius;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double? blur;
  final Color? borderSideColor;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final List<BoxShadow>? shadow;

  const GradientContainer({
    super.key,
    this.child,
    this.colors = const [Color(0xFF6C63FF), Color(0xFFFF6584)],
    this.borderRadius = 20,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(20),
    this.margin = const EdgeInsets.all(20),
    this.blur,
    this.borderSideColor,
    this.begin,
    this.end,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: shadow,
        border: Border.all(
          color: borderSideColor ?? Colors.transparent,
          width: 1.1,
        ),
        gradient: LinearGradient(
          colors: colors,
          begin: begin ?? Alignment.topLeft,
          end: end ?? Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
