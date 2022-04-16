import 'package:railway_alert/storage/local/hive_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:railway_alert/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:railway_alert/bloc_cubits/theme_cubit/theme_cubit.dart';
import 'package:railway_alert/bloc_cubits/theme_cubit/theme_state.dart';
import 'package:railway_alert/bloc_cubits/auth_cubit/auth_cubit.dart';
import 'package:railway_alert/bloc_cubits/reg_cubit/reg_cubit.dart';
import 'package:railway_alert/localization/app_localization.dart';
import 'package:railway_alert/repository/auth_repository.dart';
import 'package:railway_alert/repository/lang_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/src/provider.dart';
import 'package:railway_alert/routes/app_routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:railway_alert/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveBox.create();
  //configureApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit(LangRepository())),
          BlocProvider(create: (context) => LoginCubit(AuthRepository())),
          BlocProvider(create: (context) => RegCubit(AuthRepository())),
          BlocProvider(create: (context) => AuthCubit()..isSignedIn()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
            buildWhen: (previousState, currentState) =>
                previousState != currentState,
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Company Management System',
                debugShowCheckedModeBanner: false,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: context.select(
                    (ThemeCubit themeCubit) => themeCubit.state.themeMode),
                routeInformationParser: VxInformationParser(),
                routerDelegate: Routes.routerDelegate,
                locale: state.locale,
                localizationsDelegates: const [
                  AppLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''), // English, no country code
                  Locale('es', ''), // Spanish, no country code
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
              );
            }),
      ),
    );
  }
}
