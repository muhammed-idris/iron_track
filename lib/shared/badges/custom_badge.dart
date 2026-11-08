import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    required this.assetImage,
    required this.imageWidth,
    required this.imageHeight,
    required this.positionDumbbellTop,
    required this.colorImage,
    required this.positionDumbbellRight,
    required this.customIconSize,
    this.colorIconColor,
  });

  final String assetImage;
  final double imageWidth;
  final double imageHeight;
  final double positionDumbbellTop;
  final double positionDumbbellRight;
  final Color colorImage;
  final Color? colorIconColor;
  final double customIconSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          assetImage,
          width: imageWidth,
          height: imageHeight,
          colorFilter: ColorFilter.mode(colorImage, BlendMode.srcIn),
          fit: BoxFit.contain,
        ),
        Positioned(
          top: positionDumbbellTop,
          right: positionDumbbellRight,
          child: FaIcon(
            FontAwesomeIcons.dumbbell,
            size:customIconSize ,
            color: colorIconColor,
          ),
        ),
      ],
    );
  }
}