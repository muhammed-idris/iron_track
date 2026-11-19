import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';
import '../../../shared/containers/info_divider.dart';

class AddExeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddExeAppBar({
    super.key,
    required this.appBarTitle,
    this.onBack,
  });

  final String appBarTitle;

  final VoidCallback? onBack;

  static const double _toolbarHeight = 80;
  static const double _backButtonSize = 44;

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final glass = context.glass;

    return AppBar(
      toolbarHeight: _toolbarHeight,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leadingWidth: _backButtonSize + 24,
      leading: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8),
          child: Semantics(
            button: true,
            label: 'Back',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onBack ?? () => Navigator.maybePop(context),
              child: CustomGlassCard(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                width: _backButtonSize,
                height: _backButtonSize,
                borderRadius: 15,
                gradient: LinearGradient(colors: glass.surfaceGradient),
                borderColors: glass.borderColors,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: glass.copyColor,
                    size: 17,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appBarTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.appBar.copyWith(color: glass.textPrimary),
            ),
            const Gap(7),
            InfoDivider(
              margin: 10,
              color: glass.textMuted.withValues(alpha: 0.6),
              width: width * .35,
              height: 4,
              topLeft: 30,
              topRight: 30,
              bottomLeft: 30,
              bottomRight: 30,
            ),
          ],
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