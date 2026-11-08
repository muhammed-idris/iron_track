import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/gradient_container.dart';
import 'package:iron_track/shared/customs/custom_btn.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';

Future<bool?> showDeleteConfirmationDialog(
  BuildContext context, {
  required String itemName,
  String title = 'Delete Item?',
}) {
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.65),
    builder: (dialogContext) {
      final size = MediaQuery.sizeOf(dialogContext);
      final width = size.width;
      final height = size.height;
      final glass = dialogContext.glass;

      return Dialog(
        backgroundColor: glass.dialogBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientContainer(
                width: width * 0.15,
                height: width * 0.15,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                borderRadius: 20,
                colors: glass.dangerIconBackground,
                child: Center(
                  child: Icon(
                    Icons.delete_outline,
                    color: glass.dangerIconColor,
                    size: 40,
                  ),
                ),
              ),
              Gap(height * 0.035),
              Text(
                title,
                style: TextStyles.headline2.copyWith(
                  color: glass.textPrimary,
                ),
              ),
              Gap(height * 0.01),
              Text(
                "$itemName will be permanently removed. This can't be undone.",
                textAlign: TextAlign.center,
                style: TextStyles.subtitle.copyWith(
                  color: glass.textMuted,
                  height: 1.4,
                ),
              ),
              Gap(height * 0.03),
              Row(
                children: [
                  Expanded(
                    child: CustomBtn(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(dialogContext, false);
                      },
                      text: 'Cancel',
                      btnColors: [glass.hintText, glass.hintText],
                      animateIn: true,
                    ),
                  ),
                  Gap(width * 0.02),
                  Expanded(
                    child: CustomBtn(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        Navigator.pop(dialogContext, true);
                      },
                      text: 'Delete',
                      icon: Icons.delete_rounded,
                      btnColors: [
                        AppColor.danger,
                        AppColor.danger.withValues(alpha: 0.8),
                      ],
                      animateIn: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
