import 'package:material_ui/material_ui.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';

/// Quiet inline text link for auth forms.
class AuthTextLink extends StatelessWidget {
  const AuthTextLink({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
  });

  final String text;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
      ),
      child: Text(
        text,
        style: context.text.bodySmall.copyWith(
          color: color ?? AppColor.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// "Already have an account? Log in" style footer row.
class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    super.key,
    required this.prompt,
    required this.action,
    required this.onTap,
  });

  final String prompt;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prompt,
          style: context.text.bodySmall.copyWith(color: glass.hintText),
        ),
        AuthTextLink(text: action, onTap: onTap),
      ],
    );
  }
}
