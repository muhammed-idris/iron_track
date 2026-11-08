import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class CustomGlassCard extends StatelessWidget {
  const CustomGlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.widthFactor,
    this.heightFactor,
    this.constraints,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 20,
    this.blur = 20,
    this.borderWidth = 1,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.borderColors,
    this.borderGradient,
    this.shadow,
    this.gradient,
  });

  final Widget child;
  final double? width;
  final double? height;
  final double? widthFactor;
  final double? heightFactor;
  final BoxConstraints? constraints;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderRadius;
  final double blur;
  final double borderWidth;
  final Color backgroundColor;
  final Color borderColor;
  final List<Color>? borderColors;
  final Gradient? borderGradient;
  final Gradient? gradient;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);

    final resolvedWidth =
        width ?? (widthFactor != null ? screen.width * widthFactor! : null);

    final resolvedHeight =
        height ?? (heightFactor != null ? screen.height * heightFactor! : null);

    final radius = BorderRadius.circular(borderRadius);


    final resolvedBorderGradient = borderGradient ??
        LinearGradient(
          colors: borderColors ?? [borderColor, borderColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );

    final cardContent = DecoratedBox(
      decoration: BoxDecoration(
        color: gradient == null ? backgroundColor : null,
        gradient: gradient,
        borderRadius: radius,
        border: GradientBoxBorder(
          gradient: resolvedBorderGradient,
          width: borderWidth,
        ),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    return Container(
      width: resolvedWidth,
      height: resolvedHeight,
      margin: margin,
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: shadow,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: blur > 0
            ? BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: cardContent,
        )
            : cardContent,
      ),
    );
  }
}