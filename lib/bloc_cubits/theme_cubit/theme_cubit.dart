import 'package:railway_alert/bloc_cubits/theme_cubit/theme_state.dart';
import 'package:railway_alert/repository/lang_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railway_alert/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ThemeCubit extends Cubit<ThemeState> {
  LangRepository langRepository;

  ThemeCubit(this.langRepository) : super(const ThemeState(themeMode: ThemeMode.light)) {
    updateAppTheme();changeStartLang();
  }

  void updateAppTheme() {
    final Brightness? currentBrightness = AppThemes.currentSystemBrightness;
    currentBrightness == Brightness.light ? _setTheme(ThemeMode.light) : _setTheme(ThemeMode.dark);
  }

  void _setTheme(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      AppThemes.themeData(false);
    } else {
      AppThemes.themeData(true);
    }
    emit(ThemeState(themeMode: themeMode));
  }

  void changeStartLang() async {
    //var langCode = await SecStore.getValue(keyVal: 'lang');
    langRepository.init().then((value) {
      var langCode = langRepository.getLang();

      if (langCode != "") {
        emit(SelectedLocale(Locale(langCode, '')));
      } else {
        emit(SelectedLocale(
            Locale(ui.window.locale.toString().split('_')[0], '')));
      }
    });
  }

  Future<void> changeLang(context, String data) async {
    emit(SelectedLocale(Locale(data, '')));
    langRepository.init().then((value) {
      langRepository.saveLang(data);
    });
    //await SecStore.setValue(keyVal: 'lang', value: data);
  }
}
