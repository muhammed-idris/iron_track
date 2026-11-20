import 'package:material_ui/material_ui.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'fade_slide_in.dart';

/// Shared layout shell for authentication screens.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.children,
    this.showBack = false,
  });

  final List<Widget> children;
  final bool showBack;

  static const double _maxContentWidth = 440;
  static const double _horizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(child: _AmbientGlow()),
            SafeArea(
              child: Column(
                children: [
                  if (showBack) const _BackBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(
                        _horizontalPadding,
                        showBack ? 8 : 28,
                        _horizontalPadding,
                        32,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints:
                              const BoxConstraints(maxWidth: _maxContentWidth),
                          child: FadeSlideIn(
                            child: Column(children: children),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.9),
            radius: 0.95,
            colors: [
              AppColor.primary.withValues(alpha: 0.16),
              AppColor.primary.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackBar extends StatelessWidget {
  const _BackBar();

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Semantics(
          button: true,
          label: 'Back',
          child: Material(
            color: glass.mutedBorder.withValues(alpha: 0.35),
            shape: CircleBorder(side: BorderSide(color: glass.mutedBorder)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Navigator.maybePop(context),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: glass.hintText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
