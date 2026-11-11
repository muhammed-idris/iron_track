import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:gap/gap.dart';
import '../../../shared/containers/crystal_container.dart';


class CaloriesButton extends StatefulWidget {
  final IconData buttonIcon;
  final String iconText;
  final Color backColor;
  final VoidCallback func;
  final double? buttonHeight;
  final double? buttonWidth;
  const CaloriesButton({
    super.key,
    required this.buttonIcon,
    required this.iconText,
    required this.backColor,
    required this.func,
    this.buttonHeight,
    this.buttonWidth});

  @override
  State<CaloriesButton> createState() => _CaloriesButtonState();
}

class _CaloriesButtonState extends State<CaloriesButton> {
  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: widget.func,
      child: CustomGlassCard(
        width: widget.buttonWidth ?? width * 1,
        height: widget.buttonHeight ?? height * 0.1 ,
        shadow: [
          BoxShadow(
            color: glass.shadowColor,
            blurRadius: 5,
            offset: const Offset(0, 8),
          ),
        ],

        margin: EdgeInsets.zero,
        backgroundColor:widget.backColor,
        borderRadius: 12,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
             Icon(widget.buttonIcon, color: glass.textPrimary, size: 15),
            const Gap(5),
            Text(widget.iconText, style: context.text.headline1),
          ],
        ),
      ),
    );
  }
}
