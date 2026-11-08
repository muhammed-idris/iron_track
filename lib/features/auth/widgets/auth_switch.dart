import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';

class AuthSwitch extends StatelessWidget {
  const AuthSwitch({
    super.key,
    required this.isLogin,
    required this.onChanged,
  });

  final bool isLogin;
  final ValueChanged<bool> onChanged;

  static const _duration = Duration(milliseconds: 250);
  static const _curve = Curves.easeInOutBack;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;



    return CustomGlassCard(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.05,
        ),
        borderColors: [glass.dividerColor, glass.dividerColor],
        borderRadius: 12,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.001,
          vertical: height * 0.001,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: glass.surfaceGradient,
        ),
      child: CustomGlassCard(
        height: height * 0.052,
        padding: const EdgeInsets.all(4),
        borderRadius: 12,
        backgroundColor: Colors.transparent,
        blur: 0,
        child: Row(
          children: [
            _SwitchItem(
              title: 'LOG IN',
              selected: isLogin,
              gradient: glass.accentSurfaceGradient,
              onTap: () => onChanged(true),
            ),
            _SwitchItem(
              title: 'SIGN UP',
              selected: !isLogin,
              gradient: glass.accentSurfaceGradient,
              onTap: () => onChanged(false),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchItem extends StatelessWidget {
  const _SwitchItem({
    required this.title,
    required this.selected,
    required this.gradient,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final List<Color> gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;

    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: title,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: selected ? null : onTap,
          child: AnimatedContainer(
            duration: AuthSwitch._duration,
            curve: AuthSwitch._curve,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: selected ? LinearGradient(colors: gradient) : null,
            ),
            child: AnimatedDefaultTextStyle(
              duration: AuthSwitch._duration,
              curve: AuthSwitch._curve,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.4,
                color: selected ? glass.textPrimary : glass.hintText,
              ),
              child: Text(title),
            ),
          ),
        ),
      ),
    );
  }
}