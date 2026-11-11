import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/features/auth/view/login_view.dart';
import '../../../core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';
import '../../../shared/customs/custom_animate.dart';
import '../../../shared/customs/custom_snack_bar.dart';
import '../widgets/dark_theme_row.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_card_widget.dart';
import '../widgets/setting_row.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final glass = context.glass;

    return Scaffold(
      appBar: const ProfileAppBar(title: 'Profile'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.01,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.01,
                horizontal: width * 0.03,
              ),
              child: const ProfileCardWidget(),
            ),
            Gap(height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: context.text.headline2.copyWith(
                      color: glass.hintText,
                    ),
                  ),
                ],
              ),
            ),
            Gap(height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: CustomGlassCard(
                shadow: [
                  BoxShadow(
                    color: glass.shadowColor,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 20,
                  bottom: 20,
                ),
                blur: 15,
                margin: EdgeInsets.zero,
                borderGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: glass.surfaceGradient,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: glass.exerciseBackground,
                ),
                borderRadius: 15,
                child: Column(
                  children: [
                    const DarkThemeRow(),
                    Gap(height * 0.01),
                    SettingsTile(
                      icon: Icons.notifications_rounded,
                      title: 'Notifications',
                      onTap: () {
                        AppSnackBar.comingSoon(
                          context: context,
                          message: 'Notifications Settings - Coming Soon',
                        );
                      },
                    ),
                    Gap(height * 0.005),
                    SettingsTile(
                      icon: Icons.logout_rounded,
                      title: 'Log Out',
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const LoginView(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).slideUp(
          delay: 10.ms,
          duration: 700.ms,
          curve: Curves.easeInOut,
          begin: 0.005,
          end: 0.0,
        ),
      ),
    );
  }
}
