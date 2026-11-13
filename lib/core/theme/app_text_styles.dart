import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_track/core/constants/app_theme_extension.dart';
import 'package:iron_track/core/constants/colors_manager.dart';

/// Centralized typography design system bound to [GlassTheme].
@immutable
class AppTextStyles {
  const AppTextStyles(this.glass);

  final GlassTheme glass;

  /// Large display text for hero sections & splash screens (Anton).
  TextStyle get display => GoogleFonts.anton(
        fontSize: 53,
        fontWeight: FontWeight.normal,
        color: AppColor.primary,
      );

  /// Standard app bar title text style (Plus Jakarta Sans).
  TextStyle get appBar => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: glass.textPrimary,
      );

  /// Stylized, uppercase title style for prominent titles (Bebas Neue).
  TextStyle get appBarTitle => GoogleFonts.bebasNeue(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: glass.textPrimary,
        letterSpacing: 2,
      );

  /// Primary headline text style (Plus Jakarta Sans).
  TextStyle get headline1 => GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: glass.textPrimary,
      );

  /// Secondary headline / section title text style.
  TextStyle get headline2 => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: glass.textPrimary,
      );

  /// Subtitle style for muted secondary metadata.
  TextStyle get subtitle => GoogleFonts.plusJakartaSans(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: glass.textMuted,
      );

  /// Default body text style.
  TextStyle get body => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: glass.textPrimary,
        height: 1.5,
      );

  /// Compact body text style.
  TextStyle get bodySmall => GoogleFonts.plusJakartaSans(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: glass.textPrimary,
      );

  /// Prominent numeric displays (stats, calories, reps).
  TextStyle get numbers => GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: glass.textPrimary,
        height: 1.1,
        letterSpacing: -0.5,
      );

  /// Overline uppercase label style.
  TextStyle get overline => GoogleFonts.plusJakartaSans(
        fontSize: 8,
        fontWeight: FontWeight.w500,
        color: glass.textPrimary,
        letterSpacing: 1.2,
      );

  /// Button label style for smaller action buttons.
  TextStyle get buttonSmall => GoogleFonts.plusJakartaSans(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: AppColor.white,
      );

  /// Text style for success statuses and positive indicators.
  TextStyle get success => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: glass.successColor,
      );

  /// Badge tag text style.
  TextStyle get badge => GoogleFonts.plusJakartaSans(
        fontSize: 9,
        fontWeight: FontWeight.w600,
        color: GridColor.red50,
        letterSpacing: 0.5,
      );
}
