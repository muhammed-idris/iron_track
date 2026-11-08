import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../core/constants/colors_manager.dart';
import '../../core/constants/text_styles.dart';

class CustomTxtField extends StatelessWidget {
  const CustomTxtField({
    super.key,
    this.hintText,
    this.controller,
    required this.borderCurve,
    required this.fieldColor,
    this.hntColor,
    this.borderColor,
    required this.keyboardType,
    this.onEditingComplete,
    this.readOnly,
    this.focusColor,
  });

  final String? hintText;
  final TextEditingController? controller;
  final BorderRadius borderCurve;
  final Color? fieldColor;
  final Color? hntColor;
  final Color? borderColor;
  final Color? focusColor;
  final TextInputType keyboardType;
  final VoidCallback? onEditingComplete;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;

    return TextFormField(
      textCapitalization: TextCapitalization.words,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      style: TextStyles.body.copyWith(color: glass.textPrimary),
      cursorColor: AppColor.primary,
      controller: controller,
      onEditingComplete: onEditingComplete,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        fillColor: fieldColor ?? Colors.transparent,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: borderCurve,
          borderSide: BorderSide(
            color: borderColor ?? AppColor.grey600,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderCurve,
          borderSide: BorderSide(
            color: focusColor ?? AppColor.primary,
            width: 2,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hntColor ?? AppColor.grey600,
          fontSize: 13,
        ),
      ),
    );
  }
}