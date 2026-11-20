import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/customs/custom_snack_bar.dart';

/// "Or continue with" divider widget.
class OrDivider extends StatelessWidget {
  const OrDivider({super.key, this.label = 'Or continue with'});

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
            label,
            style: context.text.bodySmall.copyWith(color: glass.hintText),
          ),
        ),
        Expanded(
          child: Divider(color: glass.mutedBorder, thickness: 1, height: 1),
        ),
      ],
    );
  }
}

/// Social sign-in buttons (Apple + Google).
class ContinueWithButton extends StatelessWidget {
  const ContinueWithButton({
    super.key,
    this.onAppleTap,
    this.onGoogleTap,
  });

  final VoidCallback? onAppleTap;
  final VoidCallback? onGoogleTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SocialAuthButton(
            label: 'Apple',
            icon: FontAwesomeIcons.apple,
            iconSize: 20,
            onTap: onAppleTap ??
                () => AppSnackBar.comingSoon(
                      context: context,
                      message: 'Apple Sign-In - Coming Soon',
                    ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: _SocialAuthButton(
            label: 'Google',
            icon: FontAwesomeIcons.google,
            iconSize: 17,
            onTap: onGoogleTap ??
                () => AppSnackBar.comingSoon(
                      context: context,
                      message: 'Google Sign-In - Coming Soon',
                    ),
          ),
        ),
      ],
    );
  }
}

class _SocialAuthButton extends StatefulWidget {
  const _SocialAuthButton({
    required this.label,
    required this.icon,
    required this.iconSize,
    required this.onTap,
  });

  final String label;
  final FaIconData icon;
  final double iconSize;
  final VoidCallback onTap;

  @override
  State<_SocialAuthButton> createState() => _SocialAuthButtonState();
}

class _SocialAuthButtonState extends State<_SocialAuthButton> {
  bool _isPressed = false;

  void _setPressed(bool v) => setState(() => _isPressed = v);

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final foreground = Theme.of(context).colorScheme.onSurface;
    final radius = BorderRadius.circular(16);

    return Semantics(
      button: true,
      label: 'Continue with ${widget.label}',
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: glass.dividerColor),
            boxShadow: [
              BoxShadow(
                color: glass.shadowColor.withValues(alpha: 0.14),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: glass.dialogBackground,
            borderRadius: radius,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                HapticFeedback.selectionClick();
                widget.onTap();
              },
              onTapDown: (_) => _setPressed(true),
              onTapUp: (_) => _setPressed(false),
              onTapCancel: () => _setPressed(false),
              splashColor: foreground.withValues(alpha: 0.08),
              highlightColor: foreground.withValues(alpha: 0.04),
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      widget.icon,
                      size: widget.iconSize,
                      color: foreground,
                    ),
                    const Gap(10),
                    Flexible(
                      child: Text(
                        widget.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.text.buttonSmall.copyWith(
                          color: foreground,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
