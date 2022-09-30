import 'package:rapid_response/theme/app_shared_preferences_constant.dart';
import 'package:rapid_response/storage/cache/secure_storage_helper.dart';
import 'package:rapid_response/bloc_cubits/login_cubit/login_state.dart';
import 'package:rapid_response/validations/number_validation_dart.dart';
import 'package:rapid_response/validations/password_validation.dart';
import 'package:rapid_response/validations/email_validation.dart';
import 'package:rapid_response/repository/auth_repository.dart';
import 'package:rapid_response/models/login_rep_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;

  void mobileChanged(String value) {
    final mobile = Number.dirty(value);
    emit(state.copyWith(
      number: mobile,
      status: Formz.validate([mobile, state.number, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.number, state.password]),
    ));
  }

  // auth_screen logout
  Future logout() async {
    await SecStore.deleteAll();
  }

  Future<void> userLogin() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    _authRepository
        .signInWithEmail(state.number.value, state.password.value)
        .then((loginResp) {
      LoginResp? result = LoginResp.fromJson(loginResp);
      if (result != null && result.success == 0) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            exceptionError: result.message));
      } else {
        if (result.data != null) {
          SecStore.setValue(
              keyVal: SharedPreferencesConstant.USERPHONE,
              value: result.data!.phone.toString());
        }
        SecStore.setValue(
                keyVal: SharedPreferencesConstant.EMPLOYEEID,
                value: result.data!.id.toString())
            .then((value) {
          SecStore.setValue(
                  keyVal: SharedPreferencesConstant.USERTYPEID,
                  value: result.data!.userType.toString())
              .then((value) {
            SecStore.setValue(
                    keyVal: SharedPreferencesConstant.ACTIVATION,
                    value: result.data!.activation.toString())
                .then((value) {
              SecStore.setValue(
                      keyVal: SharedPreferencesConstant.DEPTID,
                      value: result.data!.deptId.toString())
                  .then((value) {
                SecStore.setValue(
                        keyVal: SharedPreferencesConstant.USEREMAIL,
                        value: result.data!.email.toString())
                    .then((value) {
                  SecStore.setValue(
                          keyVal: SharedPreferencesConstant.USERNAME,
                          value: result.data!.name.toString())
                      .then((value) {
                    emit(state.copyWith(status: FormzStatus.submissionSuccess));
                  });
                });
              });
            });
          });
        });
      }
    });
  }
}
