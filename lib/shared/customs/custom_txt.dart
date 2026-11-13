import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_track/core/theme/theme_context.dart';

/// Reusable Custom Text widget with automatic word truncation support and glass theme fallback.
class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.weight,
    this.size,
    this.firstThreeWords = false,
  });

  final String text;
  final Color? color;
  final FontWeight? weight;
  final double? size;
  final bool firstThreeWords;

  String _getFirstThreeWords(String text) {
    final words = text.trim().split(RegExp(r'\s+'));

    if (words.length <= 3) return text;

    return '${words[0]} ${words[1]} ${words[2]}..';
  }

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? context.glass.textPrimary;

    return Text(
      firstThreeWords ? _getFirstThreeWords(text) : text,
      textScaler: const TextScaler.linear(1.0),
      style: GoogleFonts.plusJakartaSans(
        color: resolvedColor,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
