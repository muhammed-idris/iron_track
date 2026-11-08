import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/customs/custom_btn.dart';
import '../../../shared/customs/custom_snack_bar.dart';
import '../widgets/auth_text_from_field.dart';
import '../widgets/top_icon_widget.dart';
import 'login_view.dart';

class ConfirmPassView extends StatefulWidget {
  const ConfirmPassView({super.key});

  @override
  State<ConfirmPassView> createState() => _ConfirmPassViewState();
}

class _ConfirmPassViewState extends State<ConfirmPassView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    AppSnackBar.success(
      context: context,
      message: 'Password updated successfully',
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: height * 0.04,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: glass.hintText,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const TopIconWidget(),
                    CustomGlassCard(
                      borderColors: glass.borderColors,
                      shadow: [
                        BoxShadow(
                          color: glass.shadowColor,
                          blurRadius: 12,
                          offset: const Offset(0, 7),
                        ),
                      ],
                      blur: 0,
                      margin: EdgeInsets.only(top: height * 0.045),
                      width: width * 0.9,
                      borderRadius: 25,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.025,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: glass.exerciseBackground,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Reset Password',
                            style: TextStyles.appBar.copyWith(
                              color: glass.textMuted,
                            ),
                          ),
                          Gap(height * 0.015),
                          AuthTextField(
                            controller: _passwordController,
                            label: 'New Password',
                            icon: Icons.lock_rounded,
                            hintText: '••••••••',
                            obscureText: true,
                            autofillHints: const [AutofillHints.newPassword],
                            validator: (v) => (v == null || v.length < 8)
                                ? 'Min 8 characters'
                                : null,
                          ),
                          Gap(height * 0.02),
                          AuthTextField(
                            controller: _confirmController,
                            label: 'Confirm Password',
                            icon: Icons.lock_rounded,
                            hintText: '••••••••',
                            obscureText: true,
                            autofillHints: const [AutofillHints.newPassword],
                            validator: (v) {
                              if (v == null || v.length < 8) {
                                return 'Min 8 characters';
                              }
                              if (v != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          Gap(height * 0.03),
                          CustomBtn(
                            text: 'Save Password',
                            btnColors: [
                              AppColor.primary,
                              AppColor.primary.withValues(alpha: 0.8),
                            ],
                            animateIn: true,
                            onTap: _handleResetPassword,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
