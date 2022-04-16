import 'package:railway_alert/theme/thems/colors_extension.dart';
import 'package:railway_alert/theme/thems/app_constants.dart';
import 'package:railway_alert/theme/thems/color_scheme.dart';
import 'package:flutter/material.dart';

enum ThemeVariant {
  light,
  dark
}

final themeVariantData = {
  ThemeVariant.light: ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    primaryColor: tempColor.lightBlueColor,
    disabledColor: tempColor.disablelightColor,
    scaffoldBackgroundColor: tempColor.backgroundColor
  ),
  ThemeVariant.dark: ThemeData(
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    primaryColor: tempColor.purpleColor,
    disabledColor: tempColor.disableDarkColor
  ),
};