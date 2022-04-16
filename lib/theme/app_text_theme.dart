import 'package:flutter/material.dart';

class AppTextStyle {
  static Function sofiaProRegular = ({Color? color, @required double? size}) =>
      _sofiaPro(color!, size!, FontWeight.w400);

  static Function sofiaProMedium = ({Color? color, @required double? size}) =>
      _sofiaPro(color!, size!, FontWeight.w500);

  static Function sofiaProBold = ({Color? color, @required double? size}) =>
      _sofiaPro(color!, size!, FontWeight.w700);

  static TextStyle _sofiaPro(Color color, double size, FontWeight fontWeight) {
    return _textStyle("SofiaPro", color, size, fontWeight);
  }
}

TextStyle _textStyle(
    String fontFamily, Color color, double size, FontWeight fontWeight) {
  return TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: size,
      fontWeight: fontWeight);
}
