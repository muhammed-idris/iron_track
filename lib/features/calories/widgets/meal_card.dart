import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/containers/crystal_container.dart';

class MealCard extends StatefulWidget {
  final String type;
  final String iconTypeCal ;
  final int amount;
  final Color iconColorCal;



  const MealCard({super.key,
    required this.type, required this.amount,
    required this.iconTypeCal, required this.iconColorCal});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final glass = context.glass;

    return CustomGlassCard(
      width: width * 0.285,
     borderGradient: LinearGradient(
       begin: Alignment.topCenter,
       end: Alignment.bottomCenter,
         colors: glass.borderColors),
      shadow: [
        BoxShadow(
          color: glass.shadowColor,
          blurRadius: 1,
          offset: const Offset(0, 2),
        ),
      ],
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      blur: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: glass.exerciseBackground,
      ),
      borderRadius: 15,
      child: Row(
        children: [
          Container(
            height: height * 0.14,
            width: width * 0.01,
            decoration: BoxDecoration(color: widget.iconColorCal),
          ),
          Gap(width * 0.03),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomGlassCard(
                margin: EdgeInsets.zero,
                blur: 30,
                borderColors: glass.exerciseBackground,
                borderRadius: 30,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.025,
                  vertical: height * 0.009,
                ),
                gradient: LinearGradient(colors: [glass.upcomingCardBorder,glass.mutedBorder]),
                child: Image.asset(widget.iconTypeCal,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: widget.iconColorCal),
              ),
              Gap(height * 0.015),
              Text(
                "${widget.amount}g",

                style: TextStyles.headline1.copyWith(color: glass.textPrimary),
              ),
              Gap(height * 0.005),
              Text(
                widget.type,
                style: TextStyles.buttonSmall.copyWith(color: glass.hintText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
