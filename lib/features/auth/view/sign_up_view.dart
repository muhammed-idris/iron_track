import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';
import '../../../root/root_screen.dart';
import '../../../shared/customs/custom_btn.dart';
import '../../../shared/customs/custom_snack_bar.dart';
import '../widgets/auth_text_from_field.dart';
import '../widgets/top_icon_widget.dart';
import 'login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isRememberMe = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (!isRememberMe) {
      AppSnackBar.error(
        context: context,
        message: 'Please agree to the Terms & Conditions',
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const RootScreen(),
      ),
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Gap(height * 0.045),
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
                            'Sign Up',
                            style: TextStyles.appBar.copyWith(
                              color: glass.textMuted,
                            ),
                          ),
                          AuthTextField(
                            controller: _nameController,
                            label: 'Full Name',
                            icon: Icons.person_rounded,
                            hintText: 'User Name',
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.name],
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Enter User Name'
                                : null,
                          ),
                          Gap(height * 0.02),
                          AuthTextField(
                            controller: _emailController,
                            label: 'Email',
                            icon: Icons.email_rounded,
                            hintText: 'you@example.com',
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            validator: (v) =>
                                (v == null || !v.trim().contains('@'))
                                    ? 'Enter a valid email'
                                    : null,
                          ),
                          Gap(height * 0.02),
                          AuthTextField(
                            controller: _passwordController,
                            label: 'Password',
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
                            controller: _confirmPasswordController,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    isRememberMe = !isRememberMe;
                                  });
                                },
                                icon: Icon(
                                  isRememberMe
                                      ? Icons.check_box_rounded
                                      : Icons.check_box_outline_blank_rounded,
                                  color: isRememberMe
                                      ? AppColor.primary
                                      : glass.hintText,
                                ),
                                label: Text(
                                  'Agree to Terms & Conditions',
                                  style: TextStyles.buttonSmall.copyWith(
                                    color: glass.hintText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(height * 0.02),
                          CustomBtn(
                            text: 'Create Account',
                            icon: Icons.check_rounded,
                            btnColors: [
                              AppColor.primary,
                              AppColor.primary.withValues(alpha: 0.8),
                            ],
                            animateIn: true,
                            onTap: _handleSignUp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyles.bodySmall.copyWith(
                                  color: glass.hintText,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginView(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  overlayColor: Colors.transparent,
                                ),
                                child: Text(
                                  'Log In',
                                  style: TextStyles.bodySmall.copyWith(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
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
