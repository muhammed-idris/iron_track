import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../core/constants/colors_manager.dart';
import '../../core/constants/text_styles.dart';
import '../../core/theme/theme_context.dart';
import '../containers/crystal_container.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Gap(height * 0.2),
            CustomGlassCard(
              margin: EdgeInsets.only(top: height * 0.02),
              width: width * 0.3,
              height: height * 0.15,
              borderRadius: 20,
              padding: EdgeInsets.zero,
              child: Center(
                child: Image.asset(
                  'assets/icons/no-wifi-solid.png',
                  color: glass.textMuted,
                ),
              ),
            ),
            Gap(height * 0.07),
            Text(
              'No Connection',
              style: TextStyles.appBar.copyWith(
                color: glass.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Gap(height * 0.01),
            Text(
              textAlign: TextAlign.center,
              'You’re offline. Check your internet\nconnection and try again.',
              style: TextStyles.headline1.copyWith(color: glass.hintText),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onRetry ?? () => Navigator.maybePop(context),
              child: CustomGlassCard(
                width: width * .85,
                height: height * .07,
                margin: EdgeInsets.symmetric(
                  horizontal: width * .05,
                  vertical: height * .05,
                ),
                borderRadius: 25,
                backgroundColor: glass.redButton,
                padding: EdgeInsets.symmetric(
                  horizontal: width * .04,
                  vertical: height * .01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(5),
                    Text(
                      'Refresh',
                      style: TextStyles.appBar.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(width * .015),
                    const Icon(
                      Icons.refresh_rounded,
                      color: AppColor.white,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
