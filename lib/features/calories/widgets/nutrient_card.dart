import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/text_styles.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../shared/customs/custom_animate.dart';
import '../../../shared/customs/custom_txt.dart';

class NutrientCard extends StatelessWidget {
  final String title;
  final int value;
  final int total;
  final Color color;
  final IconData? icon;
  final String subtitle;
  final int leftGrams;

  const NutrientCard({
    super.key,
    required this.title,
    required this.value,
    required this.total,
    required this.color,
    this.icon,
    required this.subtitle,
    required this.leftGrams,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final percent = total > 0 ? (value / total).clamp(0.0, 1.0) : 0.0;
    final glass = context.glass;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: glass.textPrimary,
                  weight: FontWeight.bold,
                  size: width * 0.035,
                ),
                Gap(height * 0.003),
                Text(
                  subtitle,
                  style: TextStyles.buttonSmall.copyWith(
                    color: glass.hintText,
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomText(
              text: '${value}g /',
              weight: FontWeight.w500,
              size: width * 0.035,
              color: glass.textPrimary,
            ),
            CustomText(
              text: ' ${total}g',
              weight: FontWeight.w500,
              size: width * 0.035,
              color: glass.hintText,
            ),
          ],
        ),
        Gap(height * 0.015),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 5,
            backgroundColor: glass.mutedBorder,
            color: color,
          ),
        ),
        Gap(height * 0.015),
        Text(
          '${leftGrams}g Left To Goal',
          style: TextStyles.bodySmall.copyWith(color: glass.hintText),
        ),
      ],
    ).slideUp(
      delay: 10.ms,
      duration: 950.ms,
      curve: Curves.easeInOut,
      begin: 0.1,
      end: 0.0,
    );
  }
}
