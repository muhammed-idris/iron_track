import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:iron_track/features/log/widgets/save_workout_button.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import '../../../../core/constants/colors_manager.dart';
import '../../../../shared/customs/custom_animate.dart';
import '../../../../shared/customs/custom_snack_bar.dart';
import '../../../home/logic/iron_track_helper.dart';

class WeekSelectorWidget extends StatefulWidget {
  final ValueChanged<int> onDaySelected;
  final TextEditingController? titleController;
  final int? initialSelectedDay;

  const WeekSelectorWidget({
    super.key,
    required this.onDaySelected,
    this.titleController,
    this.initialSelectedDay,
  });

  @override
  State<WeekSelectorWidget> createState() => _WeekSelectorWidgetState();
}

class _WeekSelectorWidgetState extends State<WeekSelectorWidget> {
  final List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  late int selectedDay;
  late TextEditingController _titleController;

  String formatDayLabel(DateTime date) {
    return DateFormat(' EEEE, MMM d').format(date);
  }

  @override
  void initState() {
    super.initState();
    selectedDay = widget.initialSelectedDay ?? 0;
    _titleController = widget.titleController ?? TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadWorkoutTitle(selectedDay);
    });
  }

  @override
  void dispose() {
    if (widget.titleController == null) {
      _titleController.dispose();
    }
    super.dispose();
  }

  Future<void> _loadWorkoutTitle(int index) async {
    final title = await IronTrackHelper.getWorkoutTitle(days[index]);
    if (!mounted) return;
    setState(() {
      _titleController.text = title ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final glass = context.glass;

    return Column(
      children: [
        CustomGlassCard(
          width: width * 0.95,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          blur: 0,
          borderRadius: 24,
          borderGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: glass.borderColors,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: glass.exerciseBackground,
          ),
          shadow: [
            BoxShadow(
              color: glass.shadowColor,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 5, 16, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Header
                          Row(
                            children: [
                              CustomGlassCard(
                                margin: EdgeInsets.zero,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),
                                borderRadius: 10,
                                borderColor: Colors.transparent,
                                gradient: LinearGradient(
                                  colors: glass.softBadgeGradient,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      size: 14,
                                      color: glass.textMuted,
                                    ),

                                    Gap(width * 0.01),

                                    Text(
                                      formatDayLabel(DateTime.now()),
                                      style: context.text.bodySmall.copyWith(
                                        color: glass.textPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Spacer(),

                              IconButton(
                                splashRadius: 22,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  AppSnackBar.comingSoon(
                                    context: context,
                                    duration: const Duration(seconds: 2),
                                    message: "Copy Workout - Coming Soon",
                                  );
                                },
                                icon: Icon(
                                  Icons.copy_rounded,
                                  size: 20,
                                  color: glass.copyColor,
                                ),
                              ),
                            ],
                          ),
                          Gap(height * 0.01),
                          SaveWorkoutButton(
                            key: ValueKey(selectedDay),
                            day: days[selectedDay],
                            initialTitle: _titleController.text,
                            onSave: (day, title) {
                              setState(() {
                                _titleController.text = title;
                              });
                            },
                          ),
                          Gap(height * 0.01),
                          SizedBox(
                            height: height * 0.065,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: days.length,
                              itemBuilder: (context, index) {
                                final bool active = selectedDay == index;
                                return InkWell(
                                  onTap: () async {
                                    HapticFeedback.selectionClick();
                                    setState(() {
                                      selectedDay = index;
                                    });
                                    await _loadWorkoutTitle(index);
                                    widget.onDaySelected(index);
                                  },
                                  enableFeedback: true,
                                  child:
                                      CustomGlassCard(
                                        shadow: [
                                          BoxShadow(
                                            color: glass.shadowColor,
                                            blurRadius: 1,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],

                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: active
                                              ? glass.selectedDay
                                              : glass.surfaceGradient,
                                        ),
                                        borderGradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: active
                                              ? glass.selectedDay
                                              : glass.borderColors,
                                        ),
                                        borderRadius: 12,
                                        margin:  EdgeInsets.only(
                                          right: width * 0.01,
                                          top: height * 0.01,
                                          bottom: height * 0.01,
                                        ),
                                        padding: EdgeInsets.zero,
                                        width: width * 0.125,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                days[index],
                                                style: context.text.buttonSmall
                                                    .copyWith(
                                                      color: active
                                                          ? AppColor.white
                                                          : glass.hintText,
                                                      fontSize: 13,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).slideLeft(
                                        delay: Duration(
                                          milliseconds: index * 80,
                                        ),
                                      ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
