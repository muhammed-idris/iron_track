import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/features/calories/views/add_meal_view.dart';
import 'package:iron_track/features/calories/widgets/nutrient_card.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import 'package:iron_track/shared/containers/info_divider.dart';
import '../../../shared/customs/custom_animate.dart';
import '../widgets/calories_app_bar.dart';
import '../widgets/calories_ring_widget.dart';

class CaloriesView extends StatefulWidget {
  final int animationTrigger;

  const CaloriesView({super.key, this.animationTrigger = 0});

  @override
  State<CaloriesView> createState() => _CaloriesViewState();
}

class _CaloriesViewState extends State<CaloriesView> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final glass = context.glass;

    return Scaffold(
      appBar: CaloriesAppBar(title: "Calories"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: width * 0.04,
            right: width * 0.04,
            top: height * 0.01,
          ),
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CaloriesRing(),
                  Gap(height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Macros",
                        style: context.text.buttonSmall.copyWith(
                          color: glass.textPrimary,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddMealView(),
                          ),
                        ),
                        onTapDown: (_) {
                          HapticFeedback.lightImpact();
                          setState(() => _pressed = true);
                        },
                        onTapUp: (_) => setState(() => _pressed = false),
                        onTapCancel: () => setState(() => _pressed = false),
                        child: AnimatedScale(
                          scale: _pressed ? 0.94 : 1.0,
                          duration: const Duration(milliseconds: 120),
                          curve: Curves.easeOut,
                          child: CustomGlassCard(
                            shadow: [
                              BoxShadow(
                                color: glass.shadowColor,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            margin: EdgeInsets.zero,
                            backgroundColor: glass.redButton,
                            borderRadius: 12,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  CupertinoIcons.add,
                                  color: AppColor.white,
                                  size: 17,
                                ),
                                const Gap(5),
                                Text(
                                  "Add Meal",
                                  style: context.text.buttonSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(height * 0.01),
                  CustomGlassCard(
                    shadow: [
                      BoxShadow(
                        color: glass.shadowColor,
                        blurRadius: 3,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.02,
                    ),
                    blur: 0,
                    borderColors: glass.borderColors,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: glass.exerciseBackground,
                    ),
                    borderRadius: 20,
                    width: width * 0.95,
                    child: Column(
                      children: [
                        NutrientCard(
                          title: "PROTEIN",
                          value: 150,
                          total: 180,
                          color: AppColor.primary,
                          subtitle: "Builds and repairs muscles",
                          leftGrams: 30,
                        ),
                        Gap(height * 0.015),
                        InfoDivider(
                          width: width * 0.8,
                          height: 2,
                          color: glass.dividerColor,
                        ),
                        Gap(height * 0.015),
                        NutrientCard(
                          leftGrams: 100,
                          title: "CARBS",
                          value: 100,
                          total: 200,
                          color: AppColor.deepOrange,
                          subtitle: "Fuel for body and brain",
                        ),
                        Gap(height * 0.015),
                        InfoDivider(
                          width: width * 0.8,
                          height: 2,
                          color: glass.dividerColor,
                        ),
                        Gap(height * 0.015),
                        NutrientCard(
                          leftGrams: 90,
                          title: "FATS",
                          value: 10,
                          total: 100,
                          color: AppColor.orange,
                          subtitle: "Essential for hormone health",
                        ),
                      ],
                    ),
                  ),
                  Gap(height * 0.1),
                ],
              ).slideUp(
                delay: 10.ms,
                duration: 700.ms,
                curve: Curves.easeInOut,
                begin: 0.005,
                end: 0.0,
              ),
        ),
      ),
    );
  }
}
