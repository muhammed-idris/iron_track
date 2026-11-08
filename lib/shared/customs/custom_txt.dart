import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Text(
      firstThreeWords ? _getFirstThreeWords(text) : text,
      textScaler: const TextScaler.linear(1.0),
      style: GoogleFonts.plusJakartaSans(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}