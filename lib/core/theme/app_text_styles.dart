
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_track/core/constants/app_theme_extension.dart';
import 'package:iron_track/core/constants/colors_manager.dart';

class AppTextStyles {
  const AppTextStyles(this.glass);

  final GlassTheme glass;

  TextStyle get display => GoogleFonts.anton(
    fontSize: 53,
    fontWeight: FontWeight.normal,
    color: AppColor.primary,
  );

  TextStyle get appBar => GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: glass.textPrimary,
  );

  TextStyle get appBarTitle => GoogleFonts.bebasNeue(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: glass.textPrimary,
    letterSpacing: 2,
  );

  TextStyle get headline1 => GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: glass.textPrimary,
  );

  TextStyle get subtitle => GoogleFonts.plusJakartaSans(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: glass.textMuted,
  );

  TextStyle get bodySmall => GoogleFonts.plusJakartaSans(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: glass.textPrimary,
  );

  TextStyle get headline2 => GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: glass.textPrimary,
  );

  TextStyle get numbers => GoogleFonts.plusJakartaSans(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: glass.textPrimary,
    height: 1.1,
    letterSpacing: -0.5,
  );

  TextStyle get body => GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: glass.textPrimary,
    height: 1.5,
  );

  TextStyle get overline => GoogleFonts.plusJakartaSans(
    fontSize: 8,
    fontWeight: FontWeight.w500,
    color: glass.textPrimary,
    letterSpacing: 1.2,
  );

  TextStyle get buttonSmall => GoogleFonts.plusJakartaSans(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColor.white,
  );

  TextStyle get success => GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: glass.successColor,
  );

  TextStyle get badge => GoogleFonts.plusJakartaSans(
    fontSize: 9,
    fontWeight: FontWeight.w600,
    color: GridColor.red50,
    letterSpacing: 0.5,
  );
}
