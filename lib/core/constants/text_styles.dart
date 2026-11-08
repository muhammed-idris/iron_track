import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors_manager.dart';


class TextStyles {
  TextStyles._();

  static final TextStyle display = GoogleFonts.anton(
    fontSize: 55,
    fontWeight: FontWeight.normal,
    color: AppColor.primary,
  );

  static final TextStyle appBar = GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColor.white,
  );

  static final TextStyle appBarTitle = GoogleFonts.bebasNeue(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColor.white,
    letterSpacing: 2,
  );

  static final TextStyle headline1 = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.white,
  );

  static final TextStyle subtitle = GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColor.primary,
  );

  static final TextStyle bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
  );

  static final TextStyle headline2 = GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
  );

  static final TextStyle numbers = GoogleFonts.plusJakartaSans(
    fontSize: 23,
    fontWeight: FontWeight.w600,
    color: AppColor.white,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static final TextStyle body = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColor.white,
    height: 1.5,
  );

  static final TextStyle overline = GoogleFonts.plusJakartaSans(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    color: AppColor.white,
    letterSpacing: 1.2,
  );

  static final TextStyle buttonSmall = GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final TextStyle success = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColor.success,
  );

  static final TextStyle badge = GoogleFonts.plusJakartaSans(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: GridColor.red50,
    letterSpacing: 0.5,
  );
}
