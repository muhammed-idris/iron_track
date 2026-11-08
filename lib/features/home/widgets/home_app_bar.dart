import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HomeAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;
    final glass = context.glass;

    return AppBar(
      toolbarHeight: 90,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back,',
                style: context.text.subtitle.copyWith(
                  color: glass.hintText,
                ),
              ),
              Row(
                children: [
                  Text(
                    title,
                    style: context.text.appBar.copyWith(
                      color: glass.textPrimary,
                    ),
                  ),
                  Gap(width * 0.015),
                  // SvgPicture.asset(
                  //   'assets/badges/award-star-rounded.svg',
                  //   colorFilter: const ColorFilter.mode(
                  //     AppColor.primary,
                  //     BlendMode.srcIn,
                  //   ),
                  //   width: width * 0.05,
                  //   height: height * 0.025,
                  // ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Track. Compete. ',
                    style: context.text.subtitle.copyWith(
                      color: glass.hintText,
                    ),
                  ),
                  Text(
                    'Dominate',
                    style: context.text.subtitle.copyWith(
                      color: glass.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
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
                    Icons.notifications_none_rounded,
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
