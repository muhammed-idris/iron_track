import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/constants/text_styles.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/home/widgets/start_workout_btn.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import 'package:iron_track/shared/containers/info_divider.dart';

import '../../log/views/log_view.dart';
import '../data/workout_model.dart';

class WorkoutCard extends StatefulWidget {
  const WorkoutCard({
    super.key,
    required this.workout,
    required this.dateLabel,
  });

  final WorkoutModel workout;
  final String dateLabel;

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  bool isPressed = false;

  String formatExerciseCount(int exercises) {
    return "$exercises ${exercises == 1 ? "Exercise" : "Exercises"}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;
    final totalTime = widget.workout.exercises.fold<int>(0,
      (sum, exercise) => sum + ((exercise.setsCount ?? 0) * 4),
    );

    return CustomGlassCard(
      shadow: [
        BoxShadow(
          color: glass.shadowColor,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
      borderColors: glass.borderColors,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: glass.exerciseBackground,
      ),
      blur: 15,
      margin: EdgeInsets.only(bottom: height * 0.01),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * .02,
        vertical: height * .01,
      ),
      borderRadius: 20,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                glass.upcomingText,
                height: height * .2,
                width: width * .4,
                fit: BoxFit.cover,
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(
              left: width * .03,
              right: width * .03,
              top: height * .055,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.workout.title,
                  style: TextStyles.headline1.copyWith(
                    color: glass.textPrimary,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(height * .015),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.dumbbell,
                      size: 11,
                      color: glass.textMuted,
                    ),
                    Gap(width * .005),
                    Text(
                      formatExerciseCount(widget.workout.exercises.length),
                      style: TextStyles.badge.copyWith(
                        color: glass.hintText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    InfoDivider(
                      margin: 10,
                      color: glass.textMuted,
                      width: width * .002,
                      height: height * .01,
                    ),

                    FaIcon(
                      FontAwesomeIcons.clock,
                      size: 11,
                      color: glass.textMuted,
                    ),

                    Gap(width * .01),

                    Text(
                      "≈ $totalTime min",
                      style: TextStyles.badge.copyWith(
                        color: glass.hintText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Gap(height * .015),

                StartWorkoutButton(workout: widget.workout),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * .02,
              vertical: height * .005,
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/calendar-check.png",
                  height: height * 0.03,
                  fit: BoxFit.cover,
                  color: glass.textMuted,
                ),
                Gap(width * .017),
                Text(
                  widget.workout.weekday ?? "",
                  style: TextStyles.body.copyWith(color: glass.textPrimary),
                ),
                const Spacer(),
                CustomGlassCard(
                      margin: EdgeInsets.zero,
                      borderRadius: 12,
                      height: height * .035,
                      padding: EdgeInsets.symmetric(horizontal: width * .025),
                      gradient: LinearGradient(colors: glass.softBadgeGradient),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Center(
                          child: Text(
                            widget.dateLabel,
                            style: TextStyles.bodySmall.copyWith(
                              color: glass.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideX(
                      begin: .15,
                      end: 0,
                      duration: 500.ms,
                      curve: Curves.easeOutCubic,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
