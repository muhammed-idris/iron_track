import 'dart:async';
import 'package:material_ui/material_ui.dart';

/// Smooth entrance animation for auth screens. Respects system reduce motion settings.
class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = const Duration(milliseconds: 60),
  });

  final Widget child;
  final Duration delay;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn> {
  bool _visible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final show = _visible || MediaQuery.disableAnimationsOf(context);
    return AnimatedSlide(
      offset: show ? Offset.zero : const Offset(0, 0.03),
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: show ? 1 : 0,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
