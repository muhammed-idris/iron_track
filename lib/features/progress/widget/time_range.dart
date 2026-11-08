import 'package:flutter/material.dart';
import '../../../core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';

class TimeRangeSelector extends StatelessWidget {
  const TimeRangeSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const List<String> options = [
    'Week',
    'Month',
    'All Time',
  ];

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final height = MediaQuery.sizeOf(context).height;

    return CustomGlassCard(
      shadow: [
        BoxShadow(
          color: glass.shadowColor,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
      gradient: LinearGradient(
        colors: glass.surfaceGradient,
      ),
      margin: EdgeInsets.symmetric(
        vertical: height * 0.005,
      ),
      blur: 10,
      padding: const EdgeInsets.all(3),
      borderRadius: 15,
      child: SizedBox(
        height: height * 0.04,
        child: Row(
          children: List.generate(
            options.length,
            (index) {
              final isSelected = selectedIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: isSelected ? glass.redButton : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      options[index],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? Colors.white : glass.hintText,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
