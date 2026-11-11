import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../shared/customs/custom_btn.dart';
import '../widgets/auth_text_from_field.dart';
import '../widgets/top_icon_widget.dart';
import 'forget_pass_code_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendCode() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ForgetPassCodeView(),
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
                            'Forgotten Password',
                            style: context.text.appBar.copyWith(
                              color: glass.textMuted,
                            ),
                          ),
                          Gap(height * 0.015),
                          AuthTextField(
                            controller: _emailController,
                            label: 'Email',
                            icon: Icons.email_rounded,
                            hintText: 'Enter Your Email',
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            validator: (v) =>
                                (v == null || !v.trim().contains('@'))
                                    ? 'Enter a valid email'
                                    : null,
                          ),
                          Gap(height * 0.03),
                          CustomBtn(
                            text: 'Send via Email',
                            btnColors: [
                              AppColor.primary,
                              AppColor.primary.withValues(alpha: 0.8),
                            ],
                            animateIn: true,
                            onTap: _handleSendCode,
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
