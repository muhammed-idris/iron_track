import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/colors_manager.dart';
import '../../core/constants/text_styles.dart';
import '../../core/theme/theme_context.dart';
import '../containers/crystal_container.dart';

class AppSnackBar {
  static OverlayEntry? _currentEntry;

  static void _removeCurrentEntry() {
    final existing = _currentEntry;
    _currentEntry = null;
    if (existing != null && existing.mounted) {
      existing.remove();
    }
  }

  static void show({
    required BuildContext context,
    required String message,
    required String typeMessage,
    Duration? duration,
    Color? backgroundColor,
    IconData? icon,
    Color? iconColor,
    Color? notificationBorderColor,
    Color? textColor,
  }) {
    if (!context.mounted) return;
    _removeCurrentEntry();

    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    final mediaQuery = MediaQuery.of(context);
    final topOffset = mediaQuery.padding.top + mediaQuery.size.height * 0.015;

    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (overlayContext) => _SnackBarOverlay(
        typeMessage: typeMessage,
        message: message,
        topOffset: topOffset,
        backgroundColor: backgroundColor ?? AppColor.grey900,
        notificationBorderColor: notificationBorderColor ?? AppColor.primary,
        icon: icon,
        iconColor: iconColor ?? AppColor.primary,
        textColor: textColor ?? AppColor.white,
        duration: duration ?? const Duration(seconds: 2),
        onDismissed: () {
          if (_currentEntry == entry) {
            _currentEntry = null;
          }
          if (entry.mounted) {
            entry.remove();
          }
        },
      ),
    );

    _currentEntry = entry;
    overlay.insert(entry);
  }

  static void success({
    required BuildContext context,
    required String message,
    Duration? duration,
    String typeMessage = 'Success',
  }) {
    show(
      context: context,
      message: message,
      typeMessage: typeMessage,
      duration: duration,
      backgroundColor: AppColor.grey900,
      notificationBorderColor: AppColor.success,
      icon: Icons.check_circle_outline_rounded,
      iconColor: AppColor.success,
      textColor: AppColor.white,
    );
  }

  static void error({
    required BuildContext context,
    required String message,
    Duration? duration,
    String typeMessage = 'Failed',
  }) {
    show(
      context: context,
      message: message,
      typeMessage: typeMessage,
      duration: duration,
      backgroundColor: AppColor.grey900,
      notificationBorderColor: AppColor.danger,
      icon: Icons.error_outline_rounded,
      iconColor: AppColor.danger,
      textColor: AppColor.white,
    );
  }

  static void comingSoon({
    required BuildContext context,
    required String message,
    Duration? duration,
    String typeMessage = 'Coming Soon',
  }) {
    show(
      context: context,
      message: message,
      typeMessage: typeMessage,
      duration: duration,
      backgroundColor: AppColor.grey900,
      notificationBorderColor: AppColor.grey,
      icon: Icons.schedule_rounded,
      iconColor: AppColor.grey,
      textColor: AppColor.white,
    );
  }
}

class _SnackBarOverlay extends StatefulWidget {
  final double topOffset;
  final String message;
  final String typeMessage;
  final Color backgroundColor;
  final Color notificationBorderColor;
  final IconData? icon;
  final Color iconColor;
  final Color textColor;
  final Duration duration;
  final VoidCallback onDismissed;

  const _SnackBarOverlay({
    required this.topOffset,
    required this.message,
    required this.typeMessage,
    required this.backgroundColor,
    required this.notificationBorderColor,
    required this.icon,
    required this.iconColor,
    required this.textColor,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<_SnackBarOverlay> createState() => _SnackBarOverlayState();
}

class _SnackBarOverlayState extends State<_SnackBarOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offset;
  Timer? _autoDismissTimer;
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
      reverseDuration: const Duration(milliseconds: 220),
    );

    _offset = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    _controller.forward();

    _autoDismissTimer = Timer(widget.duration, () {
      if (mounted && !_isDismissing) {
        _dismiss();
      }
    });
  }

  Future<void> _dismiss() async {
    if (!mounted || _isDismissing) return;
    _isDismissing = true;
    _autoDismissTimer?.cancel();

    try {
      await _controller.reverse();
    } catch (_) {
      // Ignore if controller was disposed mid-reverse
    }

    if (mounted) {
      widget.onDismissed();
    }
  }

  @override
  void dispose() {
    _autoDismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;
    final glass = context.glass;

    return Positioned(
      top: widget.topOffset > 20 ? widget.topOffset : 50,
      left: 10,
      right: 10,
      child: SlideTransition(
        position: _offset,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _dismiss,
            onVerticalDragEnd: (details) {
              if ((details.primaryVelocity ?? 0) < 0) {
                _dismiss();
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 16,
                  sigmaY: 16,
                ),
                child: CustomGlassCard(
                  shadow: [
                    BoxShadow(
                      color: glass.shadowColor,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.02,
                  ),
                  blur: 0,
                  borderWidth: 2,
                  borderColor: widget.notificationBorderColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: glass.exerciseBackground,
                  ),
                  borderRadius: 20,
                  width: width * 0.95,
                  child: Row(
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          color: widget.iconColor,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.typeMessage,
                              style: TextStyles.headline2.copyWith(
                                color: widget.textColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.message,
                              style: TextStyles.body.copyWith(
                                color: glass.hintText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
