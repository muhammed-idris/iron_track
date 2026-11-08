import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/customs/custom_snack_bar.dart';

class PressableText extends StatefulWidget {
  const PressableText({
    super.key,
    required this.text,
    required this.onTap,
    this.baseColor = const Color(0x8CFFFFFF),
    this.pressedColor = const Color(0xFFD4AF37),
  });

  final String text;
  final VoidCallback onTap;
  final Color baseColor;
  final Color pressedColor;

  @override
  State<PressableText> createState() => _PressableTextState();
}

class _PressableTextState extends State<PressableText> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: _pressed ? widget.pressedColor : glass.textPrimary,
        ),
        child: Text(widget.text),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key, this.label = 'or continue with'});

  final String label;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;

    return Row(
      children: [
        Expanded(
          child: Divider(color: glass.mutedBorder, thickness: 1, height: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label.toUpperCase(),
            style: TextStyles.subtitle.copyWith(color: glass.hintText),
          ),
        ),
        Expanded(
          child: Divider(color: glass.mutedBorder, thickness: 1, height: 1),
        ),
      ],
    );
  }
}

class ContinueWithButton extends StatelessWidget {
  const ContinueWithButton({super.key});

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final width = MediaQuery.sizeOf(context).width;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: glass.copyColor,
              foregroundColor: glass.shadowColor,
              elevation: 10,
            ),
            onPressed: () {
              AppSnackBar.comingSoon(
                context: context,
                message: 'Apple Sign-In - Coming Soon',
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.apple,
              color: glass.dividerColor,
            ),
            label: Text(
              'Apple',
              style: TextStyles.buttonSmall.copyWith(
                color: glass.dividerColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Gap(width * 0.02),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: glass.copyColor,
              foregroundColor: glass.shadowColor,
              elevation: 10,
            ),
            onPressed: () {
              AppSnackBar.comingSoon(
                context: context,
                message: 'Google Sign-In - Coming Soon',
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.google,
              color: glass.dividerColor,
            ),
            label: Text(
              'Google',
              style: TextStyles.buttonSmall.copyWith(
                color: glass.dividerColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
