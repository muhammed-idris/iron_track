import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';
import '../../log/views/log_view.dart';
import '../data/workout_model.dart';

class StartWorkoutButton extends StatefulWidget {
  const StartWorkoutButton({super.key, required this.workout});

  final WorkoutModel workout;

  @override
  State<StartWorkoutButton> createState() => StartWorkoutButtonState();
}

class StartWorkoutButtonState extends State<StartWorkoutButton> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed != value) setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;

    return GestureDetector(
      onTapDown: (_) {
        HapticFeedback.lightImpact();
        _setPressed(true);
      },
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LogView(workout: widget.workout),
          ),
        );
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: CustomGlassCard(
          margin: EdgeInsets.zero,
          borderRadius: 15,
          backgroundColor: glass.redButton,
          padding: EdgeInsets.symmetric(
            horizontal: width * .04,
            vertical: height * .01,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(5),
              Text('Start Workout', style: TextStyles.buttonSmall),
              Gap(width * .015),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.white,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
