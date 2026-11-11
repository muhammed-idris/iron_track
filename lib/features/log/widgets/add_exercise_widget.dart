import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/features/home/data/exercise_model.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import 'package:iron_track/shared/customs/custom_btn.dart';
import 'package:iron_track/shared/customs/custom_snack_bar.dart';
import 'package:iron_track/shared/customs/custom_txt_field.dart';
import '../../../core/constants/colors_manager.dart';
import '../../home/logic/iron_track_helper.dart';

enum WeightUnit { kg, lbs }

const double _kgPerLb = 0.45359237;

class AddExerciseWidget extends StatefulWidget {
  const AddExerciseWidget({
    super.key,
    required this.selectedDay,
    this.onExerciseCreated,
  });

  final String selectedDay;
  final VoidCallback? onExerciseCreated;

  @override
  State<AddExerciseWidget> createState() => _AddExerciseWidgetState();
}

class _AddExerciseWidgetState extends State<AddExerciseWidget> {
  final addExeNameController = TextEditingController();
  final addSetsController = TextEditingController();
  final addRepsController = TextEditingController();
  final addWeightController = TextEditingController();

  WeightUnit _unit = WeightUnit.kg;

  @override
  void dispose() {
    addExeNameController.dispose();
    addSetsController.dispose();
    addRepsController.dispose();
    addWeightController.dispose();
    super.dispose();
  }
  // ---------- validation ----------
  bool _showErrorIf(String? message) {
    if (message == null) return false;
    AppSnackBar.error(
      context: context,
      message: message,
      duration: const Duration(seconds: 2),
    );
    return true;
  }

  num? _validateNumericField({
    required String text,
    required String fieldLabel,
    bool allowDecimal = false,
    num? maxValue,
  }) {
    final trimmed = text.trim();
    final cap = '${fieldLabel[0].toUpperCase()}${fieldLabel.substring(1)}';

    if (trimmed.isEmpty) {
      _showErrorIf('Please enter $fieldLabel');
      return null;
    }
    final value = allowDecimal
        ? double.tryParse(trimmed)
        : int.tryParse(trimmed);
    if (value == null) {
      _showErrorIf('Please enter a valid $fieldLabel');
      return null;
    }
    if (value <= 0) {
      _showErrorIf('$cap must be greater than 0');
      return null;
    }
    if (maxValue != null && value > maxValue) {
      _showErrorIf('$cap must be $maxValue or less');
      return null;
    }
    return value;
  }

  Future<void> _createExercise() async {
    final title = addExeNameController.text.trim();
    if (title.isEmpty) {
      _showErrorIf('Please enter an exercise name');
      return;
    }
    if (int.tryParse(title) != null) {
      _showErrorIf('Title cannot be a number');
      return;
    }

    final sets = _validateNumericField(
      text: addSetsController.text,
      fieldLabel: 'sets',
      maxValue: 100,
    );
    if (sets == null) return;

    final reps = _validateNumericField(
      text: addRepsController.text,
      fieldLabel: 'reps',
      maxValue: 500,
    );
    if (reps == null) return;

    final weight = _validateNumericField(
      text: addWeightController.text,
      fieldLabel: 'weight',
      allowDecimal: true,
      maxValue: 100000,
    );
    if (weight == null) return;

    // Always store in kg so the rest of the app stays consistent.
    final weightKg = _unit == WeightUnit.kg
        ? weight.toDouble()
        : double.parse((weight * _kgPerLb).toStringAsFixed(2));

    await IronTrackHelper.create(
      ExerciseModel(
        exerciseTitle: title,
        setsCount: sets.toInt(),
        reps: reps.toInt(),
        weight: weightKg,
        weekday: widget.selectedDay,
      ),
    );

    addExeNameController.clear();
    addSetsController.clear();
    addRepsController.clear();
    addWeightController.clear();
    widget.onExerciseCreated?.call();

    if (!mounted) return;
    AppSnackBar.success(
      context: context,
      message: 'Exercise Added Successfully',
      duration: const Duration(seconds: 2),
    );
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomGlassCard(
          shadow: [
            BoxShadow(
              color: glass.shadowColor,
              blurRadius: 1,
              offset: const Offset(0,1),
            ),
          ],
          margin: EdgeInsets.zero,
          borderRadius: 15,
          borderGradient: LinearGradient(
            colors: glass.borderColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          gradient: LinearGradient(colors: glass.exerciseBackground),
          padding: EdgeInsets.symmetric(
            horizontal: width * .04,
            vertical: height * .02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Exercise Name", Icons.fitness_center_outlined),
              const Gap(10),
              CustomTxtField(
                keyboardType: TextInputType.text,
                borderCurve: BorderRadius.circular(10),
                controller: addExeNameController,
                hintText: "e.g, Chest Press, Squats, Deadlift",
                fieldColor: Colors.transparent,
                borderColor: glass.unSelectedColor,
                hntColor: glass.hintText,
              ),
            ],
          ),
        ),

         Gap(height * 0.02),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomGlassCard(
                shadow: [
                  BoxShadow(
                    color: glass.shadowColor,
                    blurRadius: 1,
                    offset: const Offset(0,1),
                  ),
                ],
                margin: EdgeInsets.zero,
                borderRadius: 15,
                borderGradient: LinearGradient(
                  colors: glass.borderColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                gradient: LinearGradient(colors: glass.exerciseBackground),
                padding: EdgeInsets.symmetric(
                  horizontal: width * .04,
                  vertical: height * .02,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _label("Sets", Icons.format_list_bulleted_outlined),
                      ],
                    ),
                    const Gap(12),
                    CustomTxtField(
                      keyboardType: TextInputType.number,
                      hntColor: glass.hintText,
                      fieldColor: glass.txtFieldColor,
                      borderColor: Colors.transparent,
                      borderCurve: BorderRadius.circular(11),
                      controller: addSetsController,
                      hintText: "Sets",
                    ),
                  ],
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: CustomGlassCard(
                shadow: [
                  BoxShadow(
                    color: glass.shadowColor,
                    blurRadius: 1,
                    offset: const Offset(0,1),
                  ),
                ],
                margin: EdgeInsets.zero,
                borderRadius: 15,
                borderGradient: LinearGradient(
                  colors: glass.borderColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                gradient: LinearGradient(colors: glass.exerciseBackground),
                padding: EdgeInsets.symmetric(
                  horizontal: width * .04,
                  vertical: height * .02,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _label("Reps", Icons.repeat_rounded),
                      ],
                    ),
                    const Gap(12),
                    CustomTxtField(
                      keyboardType: TextInputType.number,
                      hntColor: glass.hintText,
                      fieldColor: glass.txtFieldColor,
                      borderColor: Colors.transparent,
                      borderCurve: BorderRadius.circular(11),
                      controller: addRepsController,
                      hintText: "Reps",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Gap(height * 0.02),
        CustomGlassCard(
          shadow: [
            BoxShadow(
              color: glass.shadowColor,
              blurRadius: 1,
              offset: const Offset(0,1),
            ),
          ],
          margin: EdgeInsets.zero,
          borderRadius: 15,
          borderGradient: LinearGradient(
            colors: glass.borderColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          gradient: LinearGradient(colors: glass.exerciseBackground),
          padding: EdgeInsets.symmetric(
            horizontal: width * .04,
            vertical: height * .02,
          ),
          child: Column(
            children: [
              Row(children: [
                _label("Weight (${_unit.name})", Icons.monitor_weight_outlined),
                const Spacer()
              ]),
              const Gap(10),
              CustomTxtField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                hntColor: glass.hintText,
                borderColor: Colors.transparent,
                fieldColor: glass.txtFieldColor,
                borderCurve: BorderRadius.circular(11),
                controller: addWeightController,
                hintText: "Weight in ${_unit.name}",
              ),
            ],
          ),
        ),

        const Gap(32),
        CustomBtn(
          text: "Save Workout",
          icon: Icons.check_rounded,
          btnColors: [AppColor.primary, AppColor.primary.withValues(alpha: 0.8)],
          animateIn: true,
          onTap: () {
            _createExercise();
          },
        )
      ],
    );
  }

  Widget _label(String text, IconData icon) =>
      Row(
        children: [
          Icon(icon, color: context.glass.textMuted),
          const Gap(5),
          Text(
            text,
            style: context.text.headline2.copyWith(
                color: context.glass.textPrimary),
          ),
        ],
      );
}
