import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.appBarTitle,
    this.onBack,
  });

  final String appBarTitle;
  final VoidCallback? onBack;

  static const double _toolbarHeight = 55;
  static const double _buttonSize = 36;

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final glass = context.glass;

    return AppBar(
      primary: false,
      toolbarHeight: _toolbarHeight,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: width * 0.04,
      title: Row(
        children: [
          GestureDetector(
            onTap: onBack ?? () => Navigator.maybePop(context),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: _buttonSize,
              height: _buttonSize,
              child: CustomGlassCard(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                height: _buttonSize,
                borderRadius: 12,
                backgroundColor: glass.buttonColor,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: glass.copyColor,
                  ),
                ),
              ),
            ),
          ),
          Gap(width * 0.04),
          Expanded(
            child: Text(
              appBarTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.appBar.copyWith(
                color: glass.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}