import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';

/// Compact animated checkbox with a tappable label and haptic feedback.
class AuthCheckbox extends StatelessWidget {
  const AuthCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;

    return Semantics(
      container: true,
      checked: value,
      label: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          HapticFeedback.selectionClick();
          onChanged(!value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: value ? AppColor.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: value ? AppColor.primary : glass.hintText,
                    width: 1.5,
                  ),
                ),
                child: AnimatedScale(
                  scale: value ? 1 : 0,
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.easeOutBack,
                  child: const Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(10),
              Flexible(
                child: Text(
                  label,
                  style: context.text.buttonSmall.copyWith(
                    color: glass.hintText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
