import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/gradient_container.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../shared/containers/crystal_container.dart';

class CounterCard extends StatelessWidget {
  const CounterCard({
    super.key,
    this.title,
    required this.onMinus,
    required this.onPlus,
    this.reps,
    this.weight,
    this.value,
  });

  final String? title;
  final int? reps;
  final String? value;
  final double? weight;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;

    return CustomGlassCard(
      borderRadius: 10,
      height: height * 0.055,
      width: double.infinity,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(
        vertical: height * 0.008,
        horizontal: width * 0.02,
      ),
      backgroundColor: glass.dialogBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CounterStepButton(
            icon: CupertinoIcons.minus,
            width: width * 0.1,
            height: height * 0.042,
            iconSize: width * 0.045,
            onPressed: onMinus,
          ),
          const Gap(10),
          Center(
            child: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: Text(
                    value ?? '',
                    style: context.text.appBar.copyWith(color: glass.textPrimary),
                  ),
                ),
              ),
            ),
          ),
          const Gap(10),
          _CounterStepButton(
            icon: CupertinoIcons.add,
            width: width * 0.1,
            height: height * 0.042,
            iconSize: width * 0.045,
            onPressed: onPlus,
          ),
        ],
      ),
    );
  }
}

class _CounterStepButton extends StatelessWidget {
  const _CounterStepButton({
    required this.icon,
    required this.width,
    required this.height,
    required this.iconSize,
    required this.onPressed,
  });

  final IconData icon;
  final double width;
  final double height;
  final double iconSize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      borderRadius: 7,
      width: width,
      height: height,
      colors: const [
        GridColor.red400,
        GridColor.red600,
      ],
      child: IconButton(
        padding: EdgeInsets.zero,
        highlightColor: Colors.transparent,
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: iconSize,
          color: AppColor.white,
        ),
      ),
    );
  }
}
