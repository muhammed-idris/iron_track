import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/theme/theme_context.dart';

class DarkThemeRow extends StatefulWidget {
  const DarkThemeRow({super.key});

  @override
  State<DarkThemeRow> createState() => _DarkThemeRowState();
}

class _DarkThemeRowState extends State<DarkThemeRow> {
  @override
  Widget build(BuildContext context) {
    final glass = context.glass;

    return InkWell(
      onTap: () => context.toggleTheme(),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: Tween<double>(
                  begin: 0.75,
                  end: 1,
                ).animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: Icon(
              context.isDarkTheme
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              key: ValueKey(context.isDarkTheme),
              color: glass.hintText,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            "Dark Mode",
            style: TextStyles.headline1.copyWith(
              color: glass.textPrimary,
            ),
          ),
          const Spacer(),
          Switch.adaptive(
            value: context.isDarkTheme,
            onChanged: (_) {
              HapticFeedback.selectionClick();
              context.toggleTheme();
            },


            thumbColor: WidgetStateProperty.all(Colors.white),
            activeTrackColor: AppColor.primary,
            inactiveTrackColor: const Color(0xFFD9DCE1),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),



          ),
        ],
      ),
    );
  }
}
