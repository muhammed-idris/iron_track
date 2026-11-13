import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';

/// Reusable Divider line container with rounded corners and context glass theme styling.
class InfoDivider extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final double? margin;
  final double? topLeft;
  final double? topRight;
  final double? bottomLeft;
  final double? bottomRight;

  const InfoDivider({
    super.key,
    this.width,
    this.height,
    this.color,
    this.margin,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? context.glass.infoDivider.withValues(alpha: 0.2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? 0),
          topRight: Radius.circular(topRight ?? 0),
          bottomLeft: Radius.circular(bottomLeft ?? 0),
          bottomRight: Radius.circular(bottomRight ?? 0),
        ),
      ),
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: margin ?? 0),
    );
  }
}
