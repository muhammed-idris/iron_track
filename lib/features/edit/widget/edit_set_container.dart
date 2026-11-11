import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import 'package:iron_track/shared/customs/custom_btn.dart';
import '../../../core/constants/colors_manager.dart';
import 'container_count.dart';

class EditSetContainer extends StatefulWidget {
  const EditSetContainer({
    super.key,
    required this.reps,
    required this.weight,
    this.onDone,
  });

  final int reps;
  final double weight;
  final void Function(int reps, double weight)? onDone;

  @override
  State<EditSetContainer> createState() => EditSetContainerState();
}

class EditSetContainerState extends State<EditSetContainer> {
  static const double _cardBorderRadius = 20.0;
  static const double _cardBlur = 10.0;

  late int _reps;
  late double _weight;

  @override
  void initState() {
    super.initState();
    _reps = widget.reps;
    _weight = widget.weight;
  }

  @override
  void didUpdateWidget(covariant EditSetContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reps != widget.reps || oldWidget.weight != widget.weight) {
      _reps = widget.reps;
      _weight = widget.weight;
    }
  }

  void _incrementReps() {
    HapticFeedback.lightImpact();
    setState(() => _reps++);
  }

  void _decrementReps() {
    if (_reps <= 0) return;
    HapticFeedback.lightImpact();
    setState(() => _reps--);
  }

  void _incrementWeight() {
    HapticFeedback.lightImpact();
    setState(() => _weight++);
  }

  void _decrementWeight() {
    if (_weight <= 0) return;
    HapticFeedback.lightImpact();
    setState(() => _weight--);
  }

  void _handleSave() {
    HapticFeedback.mediumImpact();
    widget.onDone?.call(_reps, _weight);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final labelColor = context.glass.textPrimary;

    return CustomGlassCard(
      width: double.infinity,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      borderRadius: _cardBorderRadius,
      blur: _cardBlur,
      borderColor: GlassColors.glassDarkBorder4,
      borderWidth: size.width * 0.005,
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          GlassColors.glassDark1,
          GlassColors.glassDark2,
          GlassColors.glassDark3,
          GlassColors.glassDark4,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel(text: 'Reps', color: labelColor),
          CounterCard(
            value: _reps.toString(),
            onMinus: _decrementReps,
            onPlus: _incrementReps,
          ),
          Gap(size.height * 0.01),
          _FieldLabel(text: 'Weight', color: labelColor),
          CounterCard(
            value: _weight.toString(),
            onMinus: _decrementWeight,
            onPlus: _incrementWeight,
          ),
          Gap(size.height * 0.025),
          CustomBtn(
            borderRadius: 20,
            text: 'Save',
            icon: Icons.check_rounded,
            btnColors: [
              AppColor.primary,
              AppColor.primary.withValues(alpha: 0.8),
            ],
            animateIn: true,
            onTap: _handleSave,
          ),
          const Gap(10),
        ],
      ),
    )
        .animate()
        .blurXY(begin: 10, end: 0, duration: 250.ms)
        .fadeIn(duration: 350.ms);
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Text(
        text,
        style: context.text.buttonSmall.copyWith(color: color),
      ),
    );
  }
}
