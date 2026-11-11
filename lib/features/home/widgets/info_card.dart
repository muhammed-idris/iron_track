import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
class InfoCard extends StatefulWidget {
  const InfoCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.size,
  });

  final IconData icon;
  final String value;
  final String label;
  final double? size;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.aspectRatio;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final glass = context.glass;

    return CustomGlassCard(
      shadow: [
        BoxShadow(
          color: glass.shadowColor,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
      borderGradient: LinearGradient(
        begin: Alignment.topCenter,
          end:  Alignment.bottomCenter,
          colors: glass.borderColors),
      blur: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: glass.exerciseBackground,
      ),
      padding: EdgeInsets.only(
        top: height * 0.015,
        bottom: height * 0.005,
        left: width * 0.03,
        right: width * 0.03,
      ),
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomGlassCard(
              borderRadius: 10,
              padding: EdgeInsets.symmetric(horizontal: width * 0.015,vertical: height* 0.006),
              gradient: LinearGradient(colors: glass.softBadgeGradient),
              child: Icon(widget.icon, size: size * 40, color: colorScheme.primary)),
          Gap(height * 0.02),
          Text(
            widget.value,
            style: context.text.numbers.copyWith(color: glass.textPrimary),
          ),
          Gap(height * 0.005),
          Text(
            widget.label,
            style: context.text.subtitle.copyWith(color: glass.hintText),
          ),
          Gap(height * 0.015),
        ],
      ),
    );
  }
}
