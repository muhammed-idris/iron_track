import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';
import '../../../shared/customs/custom_btn.dart';
import '../../../shared/customs/custom_snack_bar.dart';
import '../widgets/top_icon_widget.dart';
import 'confirm_pass_view.dart';

class ForgetPassCodeView extends StatefulWidget {
  const ForgetPassCodeView({super.key});

  @override
  State<ForgetPassCodeView> createState() => _ForgetPassCodeViewState();
}

class _ForgetPassCodeViewState extends State<ForgetPassCodeView> {
  static const int _codeLength = 5;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_codeLength, (_) => TextEditingController());
    _focusNodes = List.generate(_codeLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _handleConfirm() {
    final code = _controllers.map((c) => c.text.trim()).join();
    if (code.length < _codeLength) {
      AppSnackBar.error(
        context: context,
        message: 'Please enter the 5-digit verification code',
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ConfirmPassView(),
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
                          style: TextStyles.appBar.copyWith(
                            color: glass.textMuted,
                          ),
                        ),
                        Gap(height * 0.03),
                        Row(
                          children: [
                            Text(
                              'Enter The Code',
                              style: TextStyles.headline2.copyWith(
                                color: glass.hintText,
                              ),
                            ),
                          ],
                        ),
                        Gap(height * 0.01),
                        SizedBox(
                          width: width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              _codeLength,
                              (index) => SizedBox(
                                width: width * 0.14,
                                height: height * 0.06,
                                child: TextField(
                                  controller: _controllers[index],
                                  focusNode: _focusNodes[index],
                                  onChanged: (v) => _onDigitChanged(index, v),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  style: TextStyles.appBar.copyWith(
                                    color: glass.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: glass.mutedBorder,
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: glass.mutedBorder,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColor.primary,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: glass.mutedBorder,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gap(height * 0.03),
                        CustomBtn(
                          text: 'Confirm',
                          btnColors: [
                            AppColor.primary,
                            AppColor.primary.withValues(alpha: 0.8),
                          ],
                          animateIn: true,
                          onTap: _handleConfirm,
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
    );
  }
}
