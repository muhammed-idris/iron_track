import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/shared/customs/custom_btn.dart';

/// Primary call-to-action button for auth screens.
class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
  });

  final String text;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = [
      AppColor.primary,
      AppColor.primary.withValues(alpha: 0.8),
    ];

    void handleTap() {
      HapticFeedback.lightImpact();
      onTap();
    }

    return CustomBtn(
      text: text,
      icon: icon,
      btnColors: colors,
      animateIn: true,
      onTap: handleTap,
    );
  }
}
