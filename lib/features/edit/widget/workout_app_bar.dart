import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';

class WorkoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WorkoutAppBar({
    super.key,
    required this.appBarTitle,
    this.onBack,
  });

  final String appBarTitle;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final glass = context.glass;

    return AppBar(
      toolbarHeight: 80,
      leading: Padding(
        padding: EdgeInsets.only(top: height * 0.025),
        child: IconButton(
          onPressed: onBack ?? () => Navigator.maybePop(context),
          icon: CustomGlassCard(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            height: height * 0.1,
            borderRadius: 15,
            gradient: LinearGradient(
              colors: glass.surfaceGradient,
            ),
            borderColors: glass.borderColors,
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: glass.copyColor,
              ),
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          appBarTitle,
          style: context.text.appBar.copyWith(
            color: glass.textPrimary,
            fontSize: 19,
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
    );
  }
}
