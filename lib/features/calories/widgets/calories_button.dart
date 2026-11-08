import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';
import '../views/add_meal_view.dart';

class CaloriesButton extends StatefulWidget {
  const CaloriesButton({super.key});

  @override
  State<CaloriesButton> createState() => _CaloriesButtonState();
}

class _CaloriesButtonState extends State<CaloriesButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final glass = context.glass;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AddMealView(),
        ),
      ),
      onTapDown: (_) {
        HapticFeedback.lightImpact();
        setState(() => _pressed = true);
      },
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: CustomGlassCard(
          shadow: [
            BoxShadow(
              color: glass.shadowColor,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          margin: EdgeInsets.zero,
          backgroundColor: glass.redButton,
          borderRadius: 15,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.add,
                color: AppColor.white,
                size: 17,
              ),
              const Gap(5),
              Text(
                "Add Meal",
                style: TextStyles.buttonSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
