import 'package:flutter/material.dart';
import 'colors_manager.dart';

@immutable
class GlassTheme extends ThemeExtension<GlassTheme> {
  final List<Color> surfaceGradient;
  final Color surfaceBorder;
  final Color backGround;
  final Color hintText;
  final Color buttonColor;
  final Color shadowColor;
  final Color redButton;
  final Color txtFieldColor;
  final String upcomingText;
  final String weekSelector;

  final List<Color> accentSurfaceGradient;
  final Color accentSurfaceBorder;

  final List<Color> badgeGradient;
  final List<Color> softBadgeGradient;
  final List<Color> softBadgeBorderGradient;

  final List<Color> upcomingCardGradient;
  final Color upcomingCardBorder;

  final Color dividerColor;
  final Color mutedBorder;

  final Color dialogBackground;
  final List<Color> dangerIconBackground;
  final Color dangerIconColor;

  final Color successColor;
  final Color textPrimary;
  final Color textMuted;

  final Color rootBackColor;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color indicatorColor;
  final Color infoDivider;

  final Color copyColor;
  final Color appBarColor;

  final Color levelContainer;

  final List<Color> selectedDay;
  final List<Color> unselectedDay;
  final List<Color> borderColors;

  final List<Color> exerciseBackground;

  const GlassTheme({
    required this.txtFieldColor,
    required this.buttonColor,
    required this.surfaceGradient,
    required this.surfaceBorder,
    required this.accentSurfaceGradient,
    required this.accentSurfaceBorder,
    required this.badgeGradient,
    required this.softBadgeGradient,
    required this.softBadgeBorderGradient,
    required this.upcomingCardGradient,
    required this.upcomingCardBorder,
    required this.dividerColor,
    required this.mutedBorder,
    required this.dialogBackground,
    required this.dangerIconBackground,
    required this.dangerIconColor,
    required this.successColor,
    required this.textPrimary,
    required this.textMuted,
    required this.backGround,
    required this.rootBackColor,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.indicatorColor,
    required this.selectedDay,
    required this.unselectedDay,
    required this.copyColor,
    required this.exerciseBackground,
    required this.hintText,
    required this.infoDivider,
    required this.shadowColor,
    required this.borderColors,
    required this.upcomingText,
    required this.redButton,
    required this.appBarColor,
    required this.levelContainer,
    required this.weekSelector,
  });

  static const dark = GlassTheme(
    txtFieldColor: GridColor.grey860,
    levelContainer: GlassColors.glassPrimary4,
    appBarColor: GridColor.grey925,
    redButton: GridColor.red600,
    buttonColor: Color(0x665C5C5C),
    upcomingText: 'assets/images/person.png',
    weekSelector: 'assets/images/week_background.png',
    borderColors: [
      GridColor.grey830,
      GridColor.grey875,
      GridColor.grey875,
      GridColor.grey875,
    ],
    infoDivider: AppColor.primary,
    hintText: AppColor.grey,
    rootBackColor: GlassColors.glassDark4,
    selectedColor: AppColor.grey400,
    unSelectedColor: AppColor.grey600,
    backGround: Color(0xFF000000),
    exerciseBackground: [
      GridColor.grey890,
      Color(0xFF0D0D0E),
    ],
    selectedDay: [
      GridColor.red600,
      GridColor.red800,
    ],
    unselectedDay: [
      GridColor.grey800,
      GridColor.grey840,
    ],
    surfaceGradient: [
      GridColor.grey850,
      GridColor.grey890,
    ],
    surfaceBorder: GridColor.grey870,
    accentSurfaceGradient: [
      Color(0xFF3E0512),
      Color(0xFF190306),
      Color(0xFF0A0102),
    ],
    accentSurfaceBorder: GlassColors.glassPrimary4,
    badgeGradient: [
      GlassColors.red300,
      GlassColors.red300,
    ],
    softBadgeGradient: [
      GlassColors.glassPrimary1,
      GlassColors.glassPrimary1,
      GlassColors.glassPrimary1,
    ],
    softBadgeBorderGradient: [
      GlassColors.glassPrimary4,
      GlassColors.glassPrimary3,
      GlassColors.glassPrimary2,
      GlassColors.glassPrimary1,
    ],
    upcomingCardGradient: [
      GridColor.grey800,
      GridColor.grey860,
      GridColor.grey800,
      GridColor.grey860,
    ],
    upcomingCardBorder: GridColor.grey870,
    dividerColor: Color(0xFF1E1E1E),
    mutedBorder: AppColor.grey800,
    dialogBackground: GridColor.grey870,
    dangerIconBackground: [GridColor.red900, GridColor.red900],
    dangerIconColor: AppColor.danger,
    successColor: AppColor.success,
    textPrimary: AppColor.white,
    textMuted: AppColor.primary,
    indicatorColor: GlassColors.red300,
    copyColor: AppColor.grey,
    shadowColor: Colors.black38,
  );

  static const light = GlassTheme(
    txtFieldColor: GridColor.white750,
    levelContainer: GlassColors.glassPrimary3,
    appBarColor: GridColor.white750,
    redButton: GridColor.red500,
    buttonColor: GlassColors.glassWhite1,
    upcomingText: 'assets/images/person_light.png',
    weekSelector: 'assets/images/week_background_light.png',
    borderColors: [
      AppColor.white,
      GridColor.white950,
    ],
    infoDivider: GridColor.red300,
    hintText: GlassColors.grey850,
    unSelectedColor: GlassColors.white700,
    selectedColor: AppColor.primary,
    rootBackColor: Colors.transparent,
    indicatorColor: GlassColors.glassRed1,
    backGround: GridColor.white800,
    exerciseBackground: [
      GridColor.white900,
      GridColor.white950,
    ],
    selectedDay: [
      GlassColors.red300,
      GridColor.red400,
    ],
    unselectedDay: [
      GridColor.grey300,
      GridColor.grey300,
    ],
    surfaceGradient: [
      Colors.white,
      GridColor.white950,
    ],
    surfaceBorder: GlassColors.glassDark4,
    accentSurfaceGradient: [
      GlassColors.glassRed2,
      GlassColors.glassRed1,
    ],
    accentSurfaceBorder: GlassColors.glassPrimary3,
    badgeGradient: [
      GlassColors.red300,
      GlassColors.red400,
    ],
    softBadgeGradient: [
      GlassColors.glassPrimary1,
      GlassColors.glassPrimary2,
    ],
    softBadgeBorderGradient: [
      GlassColors.glassPrimary1,
      GlassColors.glassPrimary2,
      GlassColors.glassPrimary3,
      GlassColors.glassPrimary4,
    ],
    upcomingCardGradient: [
      GridColor.white900,
      GridColor.white850,
      GridColor.white900,
    ],
    upcomingCardBorder: GlassColors.glassBorder4,
    dividerColor: AppColor.grey400,
    mutedBorder: Color(0xFFBDBDBD),
    dialogBackground: AppColor.white,
    dangerIconBackground: [Color(0xFFFFE1E1), Color(0xFFFFE1E1)],
    dangerIconColor: AppColor.danger,
    successColor: AppColor.success,
    textPrimary: AppColor.black,
    textMuted: AppColor.primary,
    copyColor: GridColor.grey950,
    shadowColor: AppColor.grey,
  );

  @override
  GlassTheme copyWith({
    List<Color>? surfaceGradient,
    Color? surfaceBorder,
    List<Color>? accentSurfaceGradient,
    Color? accentSurfaceBorder,
    List<Color>? badgeGradient,
    List<Color>? softBadgeGradient,
    List<Color>? softBadgeBorderGradient,
    List<Color>? upcomingCardGradient,
    Color? upcomingCardBorder,
    Color? dividerColor,
    Color? mutedBorder,
    Color? dialogBackground,
    List<Color>? dangerIconBackground,
    Color? dangerIconColor,
    Color? successColor,
    Color? textPrimary,
    Color? textMuted,
    Color? backGround,
    Color? rootBackColor,
    Color? selectedColor,
    Color? unSelectedColor,
    Color? indicatorColor,
  }) {
    return GlassTheme(
      txtFieldColor: txtFieldColor,
      weekSelector: weekSelector,
      levelContainer: levelContainer,
      appBarColor: appBarColor,
      redButton: redButton,
      buttonColor: buttonColor,
      upcomingText: upcomingText,
      borderColors: borderColors,
      shadowColor: shadowColor,
      hintText: hintText,
      unselectedDay: unselectedDay,
      selectedDay: selectedDay,
      surfaceGradient: surfaceGradient ?? this.surfaceGradient,
      surfaceBorder: surfaceBorder ?? this.surfaceBorder,
      accentSurfaceGradient:
          accentSurfaceGradient ?? this.accentSurfaceGradient,
      accentSurfaceBorder: accentSurfaceBorder ?? this.accentSurfaceBorder,
      badgeGradient: badgeGradient ?? this.badgeGradient,
      softBadgeGradient: softBadgeGradient ?? this.softBadgeGradient,
      softBadgeBorderGradient:
          softBadgeBorderGradient ?? this.softBadgeBorderGradient,
      upcomingCardGradient: upcomingCardGradient ?? this.upcomingCardGradient,
      upcomingCardBorder: upcomingCardBorder ?? this.upcomingCardBorder,
      dividerColor: dividerColor ?? this.dividerColor,
      mutedBorder: mutedBorder ?? this.mutedBorder,
      dialogBackground: dialogBackground ?? this.dialogBackground,
      dangerIconBackground: dangerIconBackground ?? this.dangerIconBackground,
      dangerIconColor: dangerIconColor ?? this.dangerIconColor,
      successColor: successColor ?? this.successColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      backGround: backGround ?? this.backGround,
      rootBackColor: rootBackColor ?? this.rootBackColor,
      selectedColor: selectedColor ?? this.selectedColor,
      unSelectedColor: unSelectedColor ?? this.unSelectedColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      copyColor: copyColor,
      exerciseBackground: exerciseBackground,
      infoDivider: infoDivider,
    );
  }

  @override
  GlassTheme lerp(ThemeExtension<GlassTheme>? other, double t) {
    if (other is! GlassTheme) return this;
    return t < 0.5 ? this : other;
  }
}
