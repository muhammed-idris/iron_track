import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/theme_context.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final height = MediaQuery.sizeOf(context).height;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.015,
          ),
          child: Row(
            children: [
              Icon(icon, size: 22, color: glass.hintText),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: context.text.headline1.copyWith(
                    color: glass.textPrimary,
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                size: 18,
                color: glass.hintText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
