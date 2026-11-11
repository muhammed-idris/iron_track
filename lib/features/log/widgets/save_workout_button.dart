import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../core/constants/app_theme_extension.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../shared/containers/crystal_container.dart';
import '../../../shared/customs/custom_snack_bar.dart';
import '../../home/logic/iron_track_helper.dart';
import '../widgets/workout_refresh_notifier.dart';

class SaveWorkoutButton extends StatefulWidget {
  final String day;
  final String? initialTitle;
  final void Function(String day, String title)? onSave;

  const SaveWorkoutButton({
    super.key,
    required this.day,
    this.initialTitle,
    this.onSave,
  });

  @override
  State<SaveWorkoutButton> createState() => _SaveWorkoutButtonState();
}

class _SaveWorkoutButtonState extends State<SaveWorkoutButton> {
  late final TextEditingController _controller;

  bool isEditing = false;

  GlassTheme get glass => context.glass;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initialTitle ?? "");
  }

  @override
  void didUpdateWidget(covariant SaveWorkoutButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialTitle != widget.initialTitle) {
      _controller.text = widget.initialTitle ?? "";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveWorkout() async {
    final title = _controller.text.trim();
    if (title.isEmpty) {
      AppSnackBar.show(
        notificationBorderColor: AppColor.danger,
        icon: Icons.error_outline_rounded,
        iconColor: AppColor.danger,
        typeMessage: "Failed",
        context: context,
        message: "Please enter a workout title",
        backgroundColor: AppColor.danger,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    if (int.tryParse(title) != null) {
      AppSnackBar.show(
        notificationBorderColor: AppColor.danger,
        icon: Icons.error_outline_rounded,
        iconColor: AppColor.danger,
        typeMessage: "Failed",
        context: context,
        message: "Title cannot be a number",
        backgroundColor: AppColor.danger,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    await IronTrackHelper.saveWorkoutTitle(widget.day, title);
    workoutRefreshNotifier.bump();
    widget.onSave?.call(widget.day, title);
    if (!mounted) return;
    FocusScope.of(context).unfocus();
    setState(() {
      isEditing = false;
    });

    AppSnackBar.show(
      notificationBorderColor: glass.successColor,
      icon: Icons.check_circle_outline_rounded,
      iconColor: glass.successColor,
      typeMessage: "Success",
      context: context,
      message: "Workout title saved",
      backgroundColor: glass.successColor,
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> _deleteWorkout() async {
    if (_controller.text.trim().isEmpty) {
      AppSnackBar.show(
        notificationBorderColor: AppColor.danger,
        icon: Icons.error_outline_rounded,
        iconColor: AppColor.danger,
        typeMessage: "Failed",
        context: context,
        message: "No workout title to delete",
        backgroundColor: AppColor.danger,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    await IronTrackHelper.deleteWorkoutTitle(widget.day);
    workoutRefreshNotifier.bump();
    _controller.clear();
    widget.onSave?.call(widget.day, "");

    if (!mounted) return;
    FocusScope.of(context).unfocus();
    setState(() {
      isEditing = false;
    });
    AppSnackBar.show(
      notificationBorderColor: AppColor.success,
      icon: Icons.check_circle_outline_rounded,
      iconColor: AppColor.success,
      typeMessage: "Success",
      context: context,
      message: "Workout title deleted",
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 250),
      crossFadeState: isEditing
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: _buildTitleView(),
      secondChild: _buildEditor(),
    );
  }

  Widget _buildTitleView() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() {
          isEditing = true;
        });
      },

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              (widget.initialTitle?.trim().isNotEmpty ?? false)
                  ? widget.initialTitle!
                  : "Add Workout",
              key: ValueKey(widget.initialTitle),
              style: context.text.appBar.copyWith(
                color: glass.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
          ),
          const Gap(10),
          Divider(height: 1, color: glass.mutedBorder),
        ],
      ),
    );
  }

  Widget _buildEditor() {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          cursorColor: AppColor.primary,
          cursorHeight: 26,
          style: context.text.appBar.copyWith(
            color: glass.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: "Workout Title",
            hintStyle: context.text.appBar.copyWith(color: glass.hintText),
            contentPadding: const EdgeInsets.only(bottom: 12),
            border: InputBorder.none,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: glass.mutedBorder, width: 2),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.primary, width: 2),
            ),
          ),
          onFieldSubmitted: (_) => _saveWorkout(),
        ),
        const Gap(22),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: _saveWorkout,
                child: CustomGlassCard(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  backgroundColor: glass.redButton,
                  borderRadius: 14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Save Workout",
                        style: context.text.buttonSmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: _deleteWorkout,
                child: CustomGlassCard(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  backgroundColor: Colors.transparent,
                  borderColor: glass.mutedBorder,
                  borderRadius: 14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        color: glass.textMuted,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Delete",
                        style: context.text.buttonSmall.copyWith(
                          color: glass.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
