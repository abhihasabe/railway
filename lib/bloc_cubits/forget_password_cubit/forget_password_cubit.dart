import 'package:rapid_response/bloc_cubits/forget_password_cubit/forget_password_state.dart';
import 'package:rapid_response/validations/number_validation_dart.dart';
import 'package:rapid_response/validations/password_validation.dart';
import 'package:rapid_response/repository/forget_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._forgetPasswordRepository)
      : super(const ForgetPasswordState());

  final ForgetPasswordRepository _forgetPasswordRepository;

  void mobileChanged(String value) {
    final mobile = Number.dirty(value);
    emit(state.copyWith(
      number: mobile,
      status: Formz.validate([mobile, state.number]),
    ));
  }

  void newPasswordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      nPassword: password,
      status: Formz.validate([password, state.nPassword, state.nsPassword]),
    ));
  }

  void confirmPasswordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      nsPassword: password,
      status: Formz.validate([password, state.nsPassword, state.nPassword]),
    ));
  }

  Future<void> changePassword() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    if (state.nPassword.value != state.nsPassword.value) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          exceptionError: "new password & confirm password not match"));
    } else {
      _forgetPasswordRepository
          .forgetPassword(state.number.value, "", state.nPassword.value)
          .then((value) =>
              {emit(state.copyWith(status: FormzStatus.submissionSuccess))});
    }
  }
}
