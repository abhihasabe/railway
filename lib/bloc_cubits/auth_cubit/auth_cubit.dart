import 'package:railway_alert/theme/app_shared_preferences_constant.dart';
import 'package:railway_alert/storage/cache/secure_storage_helper.dart';
import 'package:railway_alert/bloc_cubits/auth_cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  Future isSignedIn() async {
    Timer(const Duration(seconds: 3), () async {
      var userEmail =
          await SecStore.getValue(keyVal: SharedPreferencesConstant.USEREMAIL);
      var userType =
          await SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTID);
      if (userEmail != null && userType != null) {
        emit(const AuthLoginSuccess());
      } else {
        emit(const AuthLoginFailure());
      }
    });
  }
}
