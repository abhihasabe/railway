import 'package:railway_alert/Screens/auth_screen.dart';
import 'package:railway_alert/Screens/authentication/login_screen.dart';
import 'package:railway_alert/bloc_cubits/auth_cubit/auth_cubit.dart';
import 'package:railway_alert/bloc_cubits/auth_cubit/auth_state.dart';
import 'package:railway_alert/controllers/MenuController.dart';
import 'package:railway_alert/Screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:railway_alert/helper/dialog.helper.dart';
import 'package:railway_alert/routes/app_routes_names.dart';
import 'package:railway_alert/storage/cache/secure_storage_helper.dart';
import 'package:railway_alert/theme/app_shared_preferences_constant.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
      if (authState is AuthInitialState) {
        return const SplashScreen();
      } else if (authState is AuthLoginSuccess) {
        return const Auth();
      } else if (authState is AuthLoginFailure) {
        return const LoginScreen();
      }
      return const SplashScreen();
    });
  }
}
