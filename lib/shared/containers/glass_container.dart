import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget? child;
  final double borderRadius;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double blur;
  final Color tint;
  final Color? borderSideColor;
  final double? borderWidth;

  const GlassContainer({
    super.key,
    this.child,
    this.borderRadius = 20,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(10),
    this.blur = 10,
    this.tint = Colors.white,
    this.borderSideColor,
    this.margin,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderSideColor ?? Colors.transparent,
              width: borderWidth ?? 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
