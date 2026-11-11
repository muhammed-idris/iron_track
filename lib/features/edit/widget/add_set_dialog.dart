import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../shared/containers/gradient_container.dart';
import '../../../shared/customs/custom_btn.dart';

Future<bool?> showAddSetConfirmationDialog(BuildContext context) {
  final glass = context.glass;

  return showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: GradientContainer(
          blur: 10,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          margin: EdgeInsets.zero,
          colors: [glass.dialogBackground, glass.dialogBackground],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.add_circle_outline_rounded,
                      color: AppColor.primary,
                      size: 26,
                    ),
                    const Gap(10),
                    Text(
                      'Add Set',
                      style: context.text.headline1.copyWith(
                        color: glass.textPrimary,
                      ),
                    ),
                  ],
                ),
                const Gap(14),
                Text(
                  'Add a new set to this exercise?',
                  style: context.text.body.copyWith(color: glass.hintText),
                ),
                const Gap(28),
                Row(
                  children: [
                    Expanded(
                      child: CustomBtn(
                        text: 'Cancel',
                        btnColors: [glass.hintText, glass.hintText],
                        animateIn: true,
                        onTap: () => Navigator.pop(dialogContext, false),
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CustomBtn(
                        text: 'Add',
                        icon: Icons.check_rounded,
                        btnColors: [
                          AppColor.primary,
                          AppColor.primary.withValues(alpha: 0.8),
                        ],
                        animateIn: true,
                        onTap: () => Navigator.pop(dialogContext, true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
              .animate()
              .blurXY(begin: 10, end: 0, duration: 250.ms)
              .fadeIn(duration: 350.ms),
        ),
      );
    },
  );
}
