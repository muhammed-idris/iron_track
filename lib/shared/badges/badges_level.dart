import 'package:flutter/material.dart';


class BadgesLevel extends StatelessWidget {
  const BadgesLevel({
    super.key,
    required this.assetImage,
    required this.imageWidth,
    required this.imageHeight,

  });

  final String assetImage;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetImage,
      width: imageWidth,
      height: imageHeight,
      fit: BoxFit.cover,
    );
  }
}