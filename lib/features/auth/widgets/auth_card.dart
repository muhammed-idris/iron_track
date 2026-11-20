import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';

/// Glass card with a title header and spaced children.
class AuthCard extends StatelessWidget {
  const AuthCard({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.spacing = 16,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomGlassCard(
          borderColors: glass.borderColors,
          shadow: [
            BoxShadow(
              color: glass.shadowColor,
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
          blur: 0,
          width: constraints.maxWidth,
          borderRadius: 28,
          padding: const EdgeInsets.all(22),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: glass.exerciseBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: context.text.appBar.copyWith(color: glass.textPrimary),
              ),
              if (subtitle != null) ...[
                const Gap(6),
                Text(
                  subtitle!,
                  style: context.text.bodySmall.copyWith(
                    color: glass.hintText,
                    height: 1.4,
                  ),
                ),
              ],
              const Gap(22),
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) Gap(spacing),
                children[i],
              ],
            ],
          ),
        );
      },
    );
  }
}
