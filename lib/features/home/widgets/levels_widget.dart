import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/home/levels/levels_view.dart';
import 'package:iron_track/shared/badges/badges_level.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../shared/badges/custom_badge.dart';
import '../../../shared/containers/crystal_container.dart';

const List<Map<String, dynamic>> levelTiers = [
  {'level': 1, 'name': 'Rookie', 'minXp': 0, 'maxXp': 500, 'badgeAsset': 'assets/badges/level1.png'},
  {'level': 2, 'name': 'Beginner', 'minXp': 500, 'maxXp': 1000, 'badgeAsset': 'assets/badges/level2.png'},
  {'level': 3, 'name': 'Amateur', 'minXp': 1000, 'maxXp': 1600, 'badgeAsset': 'assets/badges/level3.png'},
  {'level': 4, 'name': 'Warrior', 'minXp': 1600, 'maxXp': 2500, 'badgeAsset': 'assets/badges/level4.png'},
  {'level': 5, 'name': 'Beast', 'minXp': 2500, 'maxXp': 3600, 'badgeAsset': 'assets/badges/level5.png'},
  {'level': 6, 'name': 'Champion', 'minXp': 3600, 'maxXp': 5000, 'badgeAsset': 'assets/badges/level6.png'},
  {'level': 7, 'name': 'Titan', 'minXp': 5000, 'maxXp': 6800, 'badgeAsset': 'assets/badges/level7.png'},
];

Map<String, dynamic> getCurrentLevelTier(double xp) {
  return levelTiers.firstWhere(
    (tier) => xp >= (tier['minXp'] as num) && xp < (tier['maxXp'] as num),
    orElse: () => levelTiers.last,
  );
}

class LevelsWidget extends StatelessWidget {
  final double volumeXp;

  const LevelsWidget({super.key, required this.volumeXp});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;
    final currentTier = getCurrentLevelTier(volumeXp);
    final minXp = (currentTier['minXp'] as num).toDouble();
    final maxXp = (currentTier['maxXp'] as num).toDouble();
    final progress = ((volumeXp - minXp) / (maxXp - minXp)).clamp(0.0, 1.0);

    return InkWell(
      borderRadius: BorderRadius.circular(19),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LevelsView(volumeXp: volumeXp)),
      ),
      child: CustomGlassCard(
        shadow: [
          BoxShadow(
            color: glass.shadowColor,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
        blur: 0,
        borderRadius: 19,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.01,
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: glass.borderColors,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: glass.exerciseBackground,
        ),
        borderWidth: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomBadge(
              assetImage: 'assets/images/hexagon-line.svg',
              colorImage: AppColor.primary,
              imageHeight: 35,
              imageWidth: 35,
              positionDumbbellTop: 11.5,
              positionDumbbellRight: 9.25,
              customIconSize: 13,
              colorIconColor: glass.textMuted,
            ),
            Gap(width * 0.03),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentTier['name'] as String,
                    style: context.text.headline1.copyWith(
                      color: glass.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 4,
                      backgroundColor: glass.mutedBorder,
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${volumeXp.toStringAsFixed(1)} / ${maxXp.toStringAsFixed(0)}',
                    style: context.text.buttonSmall.copyWith(color: glass.hintText),
                  ),
                ],
              ),
            ),
            Gap(width * 0.03),
            Text(
              'Lv. ${currentTier['level']}',
              style: context.text.headline2.copyWith(
                color: glass.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(width * 0.02),
            BadgesLevel(
              assetImage: currentTier['badgeAsset'] as String,
              imageHeight: 70,
              imageWidth: 60,
            ),
          ],
        ),
      ),
    );
  }
}
