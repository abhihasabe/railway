import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode? themeMode;
  final Locale? locale;

  const ThemeState({this.themeMode, this.locale});
}

class SelectedLocale extends ThemeState {
  SelectedLocale(Locale locale) : super(locale: locale);
}
