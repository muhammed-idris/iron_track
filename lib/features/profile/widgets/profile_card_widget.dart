import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';

class ProfileCardWidget extends StatefulWidget {
  const ProfileCardWidget({super.key});

  @override
  State<ProfileCardWidget> createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final glass = context.glass;

    return Column(
      children: [
        Row(
          children: [
            CustomGlassCard(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              borderRadius: 50,
              blur: 10,
              gradient: LinearGradient(colors: glass.surfaceGradient),
              borderColors: glass.borderColors,
              height: height * 0.08,
              width: height * 0.08,
              child: Center(
                child: Text(
                  "M",
                  style: context.text.appBar.copyWith(
                    color: glass.textPrimary,
                  ),
                ),
              ),
            ),
            Gap(width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Muhammed",
                  style: context.text.appBar.copyWith(
                    color: glass.textPrimary,
                    fontSize: width * 0.05,
                  ),
                ),
                Gap(width * 0.01),

                Text(
                  "muhammed@gmail.com",
                  style: context.text.body.copyWith(
                    color: glass.hintText,
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomGlassCard(
              margin: EdgeInsets.symmetric(vertical: height * 0.005),
              blur: 30,
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              borderRadius: 15,
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: glass.hintText,
                  size: 20,
                ),
              ),
            )

          ],
        ),
      ],
    );
  }
}
