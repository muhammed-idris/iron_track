import 'package:flutter/material.dart';
import 'package:iron_track/core/constants/text_styles.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/edit/widget/workout_app_bar.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import '../widgets/add_exe_app_bar.dart';
import '../widgets/add_exercise_widget.dart';

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({
    super.key,
    required this.selectedDay,
    this.onExerciseCreated,
  });

  final String selectedDay;
  final VoidCallback? onExerciseCreated;

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  bool isMultiple = false;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AddExeAppBar(appBarTitle: "Add Exercise"),
        backgroundColor: glass.backGround,
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddExerciseWidget(
                  selectedDay: widget.selectedDay,
                  onExerciseCreated: () {
                    widget.onExerciseCreated?.call();
                    if (!isMultiple && mounted) {
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
