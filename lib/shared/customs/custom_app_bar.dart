import 'package:flutter/material.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final glass = context.glass;

    return AppBar(
      toolbarHeight: height * 0.085,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: context.text.appBar),
              Text(
                'Track. Compete. Dominate.',
                style: context.text.subtitle,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: context.toggleTheme,
            icon: Icon(
              context.isDarkTheme
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              color: glass.textMuted,
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              CustomGlassCard(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                borderRadius: 50,
                blur: 10,
                gradient: LinearGradient(colors: glass.surfaceGradient),
                borderColors: glass.borderColors,
                height: height * 0.05,
                width: height * 0.05,
                child: Center(
                  child: Icon(
                    Icons.group_outlined,
                    color: glass.textPrimary,
                    size: 24,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 3,
                child: CustomGlassCard(
                  borderRadius: 100,
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  backgroundColor: glass.textMuted,
                  child: Center(
                    child: Text(
                      '3',
                      style: context.text.bodySmall.copyWith(
                        color: AppColor.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
