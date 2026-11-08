import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../containers/gradient_container.dart';

class CustomBtn extends StatefulWidget {
  const CustomBtn({
    super.key,
    this.btnColors,
    this.textColor,
    this.height,
    this.width,
    this.onTap,
    this.text,
    this.icon,
    this.iconColor,
    this.animateIn = false,
    this.borderRadius,
  });

  final String? text;
  final IconData? icon;
  final List<Color>? btnColors;
  final Color? textColor;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Color? iconColor;

  /// Plays a soft fade + rise when the button first appears.
  final bool animateIn;

  /// Optional corner radius. Defaults to 15.
  final double? borderRadius;

  @override
  State<CustomBtn> createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  static const double _defaultRadius = 15;
  static const Duration _minPressTime = Duration(milliseconds: 90);

  bool _pressed = false;
  DateTime? _pressStart;

  double get _radius => widget.borderRadius ?? _defaultRadius;

  bool get _enabled => widget.onTap != null;

  void _onDown() {
    if (!_enabled) return;
    HapticFeedback.lightImpact();
    _pressStart = DateTime.now();
    setState(() => _pressed = true);
  }

  // Keeps the pressed state visible long enough on very quick taps,
  // so the animation is always noticeable.
  Future<void> _release() async {
    if (!_pressed) return;
    final elapsed = DateTime.now().difference(_pressStart ?? DateTime.now());
    if (elapsed < _minPressTime) {
      await Future.delayed(_minPressTime - elapsed);
    }
    if (mounted) setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.btnColors ??
        const [Colors.transparent, Colors.transparent, Colors.transparent];
    final glowColor =
    colors.first == Colors.transparent ? Colors.black : colors.first;
    final contentColor = widget.textColor ?? Colors.white;

    Widget button = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => _onDown(),
      onTapUp: (_) => _release(),
      onTapCancel: _release,
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: Duration(milliseconds: _pressed ? 110 : 260),
        curve: _pressed ? Curves.easeOut : Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_radius),
            boxShadow: [
              BoxShadow(
                color: glowColor.withValues(alpha: _pressed ? 0.15 : 0.20),
                blurRadius: _pressed ? 6 : 18,
                spreadRadius: _pressed ? 0 : 1,
                offset: Offset(0, _pressed ? 2 : 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              GradientContainer(
                colors: colors,
                margin: EdgeInsets.zero,
                blur: 0,
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: widget.width?.toDouble() ?? double.infinity,
                height: widget.height?.toDouble() ?? 50,
                borderRadius: _radius,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        size: 22,
                        color: widget.iconColor ?? contentColor,
                      ),
                      if (widget.text != null) const SizedBox(width: 8),
                    ],
                    if (widget.text != null)
                      Text(
                        widget.text!,
                        style: TextStyle(
                          color: contentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                  ],
                ),
              ),

              // Soft darkening overlay while pressed
              Positioned.fill(
                child: IgnorePointer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_radius),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 120),
                      opacity: _pressed ? 1 : 0,
                      child: ColoredBox(
                        color: Colors.black.withValues(alpha: 0.12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Disabled look
    button = AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _enabled ? 1 : 0.5,
      child: button,
    );

    // Optional entrance animation
    if (widget.animateIn) {
      button = TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
        builder: (context, t, child) => Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 14),
            child: child,
          ),
        ),
        child: button,
      );
    }

    return button;
  }
}