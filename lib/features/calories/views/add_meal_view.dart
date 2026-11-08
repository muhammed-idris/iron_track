import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/constants/text_styles.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/calories/widgets/calories_info_card.dart';
import 'package:iron_track/features/calories/widgets/meal_card.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import 'package:iron_track/shared/customs/custom_btn.dart';
import '../../../shared/customs/custom_animate.dart';
import '../../../shared/customs/custom_snack_bar.dart';
import '../../edit/widget/workout_app_bar.dart';

class AddMealView extends StatefulWidget {
  const AddMealView({super.key});

  @override
  State<AddMealView> createState() => _AddMealViewState();
}

class _AddMealViewState extends State<AddMealView> {
  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null && mounted) {
        setState(() {
          image = File(pickedFile.path);
        });
      }
    } catch (_) {
      if (!mounted) return;
      AppSnackBar.error(
        context: context,
        message: 'Unable to access camera or gallery',
      );
    }
  }

  void _saveMeal() {
    AppSnackBar.success(
      context: context,
      message: 'Meal saved successfully',
    );
    Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;

    return Scaffold(
      appBar: const WorkoutAppBar(appBarTitle: 'Add Macros'),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: width * 0.04,
            right: width * 0.04,
            top: height * 0.01,
            bottom: height * 0.03,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: width * 0.03),
                child: Row(
                  children: [
                    Text(
                      'Rice With Chicken',
                      style: TextStyles.buttonSmall.copyWith(
                        color: glass.textPrimary,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => pickImage(ImageSource.gallery),
                child: CustomGlassCard(
                  shadow: [
                    BoxShadow(
                      color: glass.shadowColor,
                      blurRadius: 3,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  borderColors: glass.borderColors,
                  borderRadius: 25,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: glass.exerciseBackground,
                  ),
                  height: height * 0.27,
                  width: width,
                  child: image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            image!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                color: glass.hintText,
                                size: 28,
                              ),
                              Gap(height * 0.01),
                              Text(
                                'Add a photo of this meal',
                                style: TextStyles.buttonSmall.copyWith(
                                  color: glass.hintText,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ).slideUp(
                delay: 10.ms,
                duration: 700.ms,
                curve: Curves.easeInOut,
                begin: 0.1,
                end: 0.0,
              ),
              const CaloriesInfoCard(calories: 550).slideUp(
                delay: 10.ms,
                duration: 700.ms,
                curve: Curves.easeInOut,
                begin: 0.1,
                end: 0.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MealCard(
                    type: 'Protein',
                    iconTypeCal: 'assets/icons/leg.png',
                    amount: 150,
                    iconColorCal: AppColor.primary,
                  ).slideLeft(delay: 100.ms),
                  const MealCard(
                    type: 'Carbs',
                    iconTypeCal: 'assets/icons/wheat-grain.png',
                    amount: 150,
                    iconColorCal: AppColor.deepOrange,
                  ).slideLeft(delay: 200.ms),
                  const MealCard(
                    type: 'Fats',
                    iconTypeCal: 'assets/icons/trans-fat.png',
                    amount: 110,
                    iconColorCal: AppColor.orange,
                  ).slideLeft(delay: 300.ms),
                ],
              ),
              Gap(height * 0.03),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => pickImage(ImageSource.camera),
                      child: CustomGlassCard(
                        borderRadius: 15,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.only(
                          left: width * 0.035,
                          top: height * 0.01,
                          bottom: height * 0.01,
                        ),
                        borderGradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: glass.upcomingCardGradient,
                        ),
                        borderWidth: 2,
                        backgroundColor: glass.buttonColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.camera,
                              color: glass.textMuted,
                              size: 27,
                            ),
                            Gap(width * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Camera',
                                  style: TextStyles.headline2.copyWith(
                                    color: glass.textPrimary,
                                  ),
                                ),
                                Text(
                                  'Take a Photo',
                                  style: TextStyles.headline2.copyWith(
                                    color: glass.hintText,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(width * 0.03),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => pickImage(ImageSource.gallery),
                      child: CustomGlassCard(
                        borderRadius: 15,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.only(
                          left: width * 0.02,
                          top: height * 0.01,
                          bottom: height * 0.01,
                        ),
                        borderGradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: glass.upcomingCardGradient,
                        ),
                        borderWidth: 2,
                        backgroundColor: glass.buttonColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.photo_outlined,
                              color: glass.textMuted,
                              size: 30,
                            ),
                            Gap(width * 0.015),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gallery',
                                  style: TextStyles.headline2.copyWith(
                                    color: glass.textPrimary,
                                  ),
                                ),
                                Text(
                                  'Choose from gallery',
                                  style: TextStyles.headline2.copyWith(
                                    color: glass.hintText,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(height * 0.02),
              CustomBtn(
                borderRadius: 25,
                height: height * 0.06,
                text: 'Save Meal',
                icon: Icons.check_circle,
                btnColors: [
                  AppColor.primary,
                  AppColor.primary.withValues(alpha: 0.8),
                ],
                animateIn: true,
                onTap: _saveMeal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
