import 'package:material_ui/material_ui.dart';
import '../../../core/constants/app_theme_extension.dart';
import '../data/set_model.dart';
import 'edit_set_container.dart';
import 'exercise_set_card.dart';

/// Scrollable list of sets. The header lives outside (pinned in the screen).
class ExerciseSetList extends StatelessWidget {
  const ExerciseSetList({
    super.key,
    required this.entries,
    required this.expandedIndex,
    required this.width,
    required this.height,
    required this.glass,
    required this.onSelectSet,
    required this.onSaveSet,
    required this.onDeleteSet,
  });

  final List<SetEntry> entries;
  final int? expandedIndex;
  final double width;
  final double height;
  final GlassTheme glass;
  final ValueChanged<int> onSelectSet;
  final void Function(int index, int reps, double weight) onSaveSet;
  final ValueChanged<int> onDeleteSet;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        if (entries.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyState(glass: glass),
          )
        else
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              width * 0.04,
              height * 0.02,
              width * 0.04,
              height * 0.02,
            ),
            sliver: SliverList.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return _SetItem(
                  key: ObjectKey(entry),
                  index: index,
                  entry: entry,
                  isExpanded: expandedIndex == index,
                  width: width,
                  height: height,
                  glass: glass,
                  onSelect: onSelectSet,
                  onSave: onSaveSet,
                  onDelete: onDeleteSet,
                );
              },
            ),
          ),
      ],
    );
  }
}

class _SetItem extends StatelessWidget {
  const _SetItem({
    super.key,
    required this.index,
    required this.entry,
    required this.isExpanded,
    required this.width,
    required this.height,
    required this.glass,
    required this.onSelect,
    required this.onSave,
    required this.onDelete,
  });

  final int index;
  final SetEntry entry;
  final bool isExpanded;
  final double width;
  final double height;
  final GlassTheme glass;
  final ValueChanged<int> onSelect;
  final void Function(int index, int reps, double weight) onSave;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: isExpanded
              ? EditSetContainer(
            reps: entry.reps,
            weight: entry.weight,
            onDone: (reps, weight) => onSave(index, reps, weight),
          )
              : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onSelect(index),
            child: ExerciseSetCard(
              index: index,
              reps: entry.reps,
              weight: entry.weight,
              width: width,
              height: height,
              glass: glass,
              onDelete: () => onDelete(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.glass});

  final GlassTheme glass;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.fitness_center_rounded, size: 44, color: glass.hintText),
          const SizedBox(height: 12),
          Text(
            'No sets yet',
            style: TextStyle(
              color: glass.hintText,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}