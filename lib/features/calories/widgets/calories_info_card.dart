import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../shared/containers/crystal_container.dart';

class CaloriesInfoCard extends StatefulWidget {
  final int calories;

  const CaloriesInfoCard({super.key, required this.calories});

  @override
  State<CaloriesInfoCard> createState() => _CaloriesInfoCardState();
}

class _CaloriesInfoCardState extends State<CaloriesInfoCard> {
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
      padding: EdgeInsets.symmetric(vertical: height* 0.025,
          horizontal: width * 0.035),
      margin: EdgeInsets.symmetric(vertical: height * 0.015),
      borderRadius: 18,
      borderColors: glass.borderColors,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: glass.exerciseBackground,
      ),
      width: width * 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomGlassCard(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.01),
            borderRadius: 20,
            gradient: LinearGradient(colors: glass.softBadgeGradient),
            child: Icon(
              Icons.local_fire_department_outlined,
              color: glass.textMuted,
              size: 30,
            ),
          ),
          Gap(width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Text(
                    "${widget.calories}",
                    style: context.text.appBar.copyWith(color: glass.textPrimary),
                  ),
                  Gap(width * 0.01),
                  Text(
                    "kcal",
                    style: context.text.body.copyWith(color: glass.hintText),
                  ),
                ],
              ),
              Gap(height * 0.005),
              Text(
                "100 kcal left of your 650",
                style: context.text.buttonSmall.copyWith(color: glass.hintText),
              ),
            ],
          ),
          const Spacer(),
          CircularPercentIndicator(
            radius: width * 0.07,
            lineWidth: width * 0.015,
            percent: 550 / 650,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: glass.mutedBorder,
            progressColor: glass.textMuted,
            animation: true,
            center: Text(
              "77 %",
              style: context.text.buttonSmall.copyWith(color: glass.textPrimary),
            ),
          )
        ],
      ),
    );
  }
}
