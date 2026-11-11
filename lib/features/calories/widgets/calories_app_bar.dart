import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import '../../../shared/customs/custom_snack_bar.dart';

class CaloriesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CaloriesAppBar({super.key, required this.title});

  static const double _height = 90;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final glass = context.glass;

    return AppBar(
      toolbarHeight: _height,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.text.appBar.copyWith(
                    color: glass.textPrimary,
                    fontSize: 22,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Track. Compete. ',
                      style:
                          context.text.subtitle.copyWith(color: glass.hintText),
                    ),
                    Text(
                      'Dominate',
                      style: context.text.subtitle
                          .copyWith(color: glass.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomGlassCard(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            borderRadius: 50,
            blur: 10,
            gradient: LinearGradient(colors: glass.exerciseBackground),
            borderColors: glass.borderColors,
            height: _height * 0.5,
            width: _height * 0.5,
            child: IconButton(
              onPressed: () {
                AppSnackBar.comingSoon(
                  context: context,
                  duration: const Duration(seconds: 2),
                  message: 'Chat with AI - Coming Soon',
                );
              },
              icon: Icon(Icons.auto_awesome, size: width * 0.06),
              color: glass.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
