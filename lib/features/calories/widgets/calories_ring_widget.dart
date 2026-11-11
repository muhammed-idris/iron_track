import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CaloriesRing extends StatefulWidget {
  const CaloriesRing({super.key});

  @override
  State<CaloriesRing> createState() => _CaloriesRingState();
}

class _CaloriesRingState extends State<CaloriesRing> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final glass = context.glass;

    return CustomGlassCard(
      shadow: [
        BoxShadow(
          color: glass.shadowColor,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.015,
      ),
      margin: EdgeInsets.zero,
      borderRadius: 20,
      blur: 15,
      borderColors: glass.borderColors,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: glass.exerciseBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department_outlined,
                    color: glass.textMuted,
                  ),
                  Gap(width * 0.01),
                  Text(
                    "Calories",
                    style: context.text.buttonSmall.copyWith(
                      color: glass.textPrimary,
                    ),
                  ),
                ],
              ),
              Gap(height * 0.0),
              Text(
                "1,840",
                style: context.text.appBarTitle.copyWith(
                  color: glass.textPrimary,
                  fontSize: 40,
                ),
              ),

              Text(
                "of 2,400 kcal",
                style: context.text.body.copyWith(
                  color: glass.hintText,
                  fontSize: 15,
                ),
              ),
              Gap(height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomGlassCard(
                    borderRadius: 10,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                    vertical:  height * 0.005),
                    gradient: LinearGradient(colors: glass.softBadgeGradient),
                    child: Text(
                      "560 Remaining",
                      style: context.text.body.copyWith(color: glass.textPrimary),
                    ),
                  ),
                ],
              ),
            ],
          ),
          CircularPercentIndicator(
            radius: width * 0.17,
            lineWidth: width * 0.025,
            percent: 1840 / 2400,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: glass.mutedBorder,
            progressColor: glass.textMuted,
            animation: true,
            center: Column(
              children: [
                Gap(height * 0.045),
                Text(
                  "77 %",
                  style: context.text.appBar.copyWith(color: glass.textPrimary),
                ),
                Gap(height * 0.005),
                Text(
                  "Of Your Daily Goal",
                  style: context.text.buttonSmall.copyWith(
                      color: glass.hintText,
                    fontSize: 9
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
