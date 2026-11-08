import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/containers/crystal_container.dart';

class TopIconWidget extends StatelessWidget {
  const TopIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        CustomGlassCard(
          shadow: [
            BoxShadow(
              color: GridColor.red700,
              blurRadius: 100,
              offset: const Offset(0, 10),
            ),
          ],
          margin: EdgeInsets.only(top: height * 0.02),
          width: width * 0.18,
          height: height * 0.075,
          borderRadius: 20,
          padding: EdgeInsets.zero,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: glass.accentSurfaceGradient,
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.dumbbell,
              color: GridColor.red400,
              size: 28,
            ),
          ),
        ),
        Gap(height * 0.01),
        Text(
          "IRON TRACK",
          style: TextStyles.appBarTitle.copyWith(
            color: glass.textPrimary,
            fontSize: 40,
          ),
        ),
        Text(
          "Track your workouts",
          style: TextStyles.headline1.copyWith(color: glass.hintText),
        ),
      ],
    );
  }
}
