import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/auth/view/sign_up_view.dart';
import 'package:iron_track/features/auth/widgets/top_icon_widget.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';
import '../../../root/root_screen.dart';
import '../../../shared/customs/custom_btn.dart';
import '../widgets/auth_text_from_field.dart';
import '../widgets/remember_me.dart';
import 'forget_password_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isRememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const RootScreen(),
        ),
      );
    }
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
                      margin: EdgeInsets.only(top: height * 0.035),
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
                            'Login',
                            style: TextStyles.appBar.copyWith(
                              color: glass.textMuted,
                            ),
                          ),
                          AuthTextField(
                            controller: _emailController,
                            label: 'Email',
                            icon: Icons.email_rounded,
                            hintText: 'you@gmail.com',
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
                            autofillHints: const [AutofillHints.password],
                            validator: (v) => (v == null || v.length < 8)
                                ? 'Min 8 characters'
                                : null,
                          ),
                          Gap(height * 0.01),
                          Row(
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
                                  'Remember Me',
                                  style: TextStyles.buttonSmall.copyWith(
                                    color: glass.hintText,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ForgetPasswordView(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  overlayColor: Colors.transparent,
                                ),
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyles.bodySmall.copyWith(
                                    color: glass.textMuted,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(height * 0.01),
                          CustomBtn(
                            text: 'Login',
                            btnColors: [
                              AppColor.primary,
                              AppColor.primary.withValues(alpha: 0.8),
                            ],
                            animateIn: true,
                            onTap: _handleLogin,
                          ),
                          Gap(height * 0.03),
                          const OrDivider(label: 'or continue with'),
                          Gap(height * 0.025),
                          const ContinueWithButton(),
                          Gap(height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyles.bodySmall.copyWith(
                                  color: glass.hintText,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SignUpView(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  overlayColor: Colors.transparent,
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyles.bodySmall.copyWith(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(height * 0.01),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RootScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: Colors.transparent,
                            ),
                            child: Text(
                              'Guest ?',
                              style: TextStyles.headline1.copyWith(
                                color: AppColor.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
