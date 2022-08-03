import 'package:rapid_response/Screens/auth_screen.dart';
import 'package:rapid_response/Screens/authentication/login_screen.dart';
import 'package:rapid_response/bloc_cubits/auth_cubit/auth_cubit.dart';
import 'package:rapid_response/bloc_cubits/auth_cubit/auth_state.dart';
import 'package:rapid_response/Screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

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
