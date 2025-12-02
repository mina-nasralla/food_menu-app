import 'package:flutter/material.dart';

abstract class AppFonts {
  // Use dynamic font size calculation for each style
  static TextStyle styleRegular16(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleMedium16(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleSemibold16(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.w600,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleSemibold20(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 20),
        fontWeight: FontWeight.w600,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleRegular12(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 12),
        fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleSemibold24(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 24),
        fontWeight: FontWeight.w600,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleRegular14(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 14),
        fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleSemibold18(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 18),
        fontWeight: FontWeight.w600,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleBold16(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.w700,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleBold18(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 18),
        fontWeight: FontWeight.w700,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleBold20(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 20),
        fontWeight: FontWeight.w700,
    overflow: TextOverflow.ellipsis,
      );

  static TextStyle styleMedium20(BuildContext context) => TextStyle(
        fontSize: responsiveFontSize(context, fontSize: 20),
        fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
      );
}

double responsiveFontSize(BuildContext context, {required double fontSize}) {
  // Responsive font size based on screen width
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;
  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width =
      MediaQuery.of(context).size.width; // Corrected MediaQuery usage
  if (width < 600) return width / 400;
  if (width < 900) return width / 700;
  return width / 1000;
}
