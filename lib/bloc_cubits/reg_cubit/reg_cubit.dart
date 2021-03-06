import 'package:railway_alert/models/dept_resp_model.dart';
import 'package:railway_alert/models/reg_resp_model.dart';
import 'package:railway_alert/validations/confirm_password_validation.dart';
import 'package:railway_alert/validations/number_validation_dart.dart';
import 'package:railway_alert/bloc_cubits/reg_cubit/reg_state.dart';
import 'package:railway_alert/validations/password_validation.dart';
import 'package:railway_alert/validations/email_validation.dart';
import 'package:railway_alert/validations/field_validation.dart';
import 'package:railway_alert/validations/name_validation.dart';
import 'package:railway_alert/repository/auth_repository.dart';
import 'package:railway_alert/validations/dob_validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railway_alert/models/reg_req_model.dart';
import 'package:formz/formz.dart';

class RegCubit extends Cubit<RegState> {
  RegCubit(this._authRepository) : super(const RegState());

  final AuthRepository _authRepository;
  String? signupStatus;

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.email, state.password]),
    ));
  }

  void numberChanged(String value) {
    final mobileNo = Number.dirty(value);
    emit(state.copyWith(
      number: mobileNo,
      status: Formz.validate([mobileNo, state.email, state.password]),
    ));
  }

  void dobChanged(String value) {
    final dob = DOB.dirty(value.toString());
    emit(state.copyWith(
      dob: dob,
      status: Formz.validate([dob, state.email, state.password]),
    ));
  }

  void locationChanged(String value) {
    final location = Field.dirty(value.toString());
    emit(state.copyWith(
      location: location,
      status: Formz.validate([location, state.email, state.password]),
    ));
  }

  void userTypeChanged(int value) {
    final userType = Field.dirty(value.toString());
    emit(state.copyWith(
      userType: userType,
      status: Formz.validate([userType, state.email, state.password]),
    ));
  }

  void deptChanged(int value) {
    final dept = Field.dirty(value.toString());
    emit(state.copyWith(
      dept: dept,
      status: Formz.validate([dept, state.email, state.password]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.name, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.name, state.email]),
    ));
  }

  void confirmPassword(String pass, String conPass) {
    final confirmPassword =
        ConfirmPassword.dirty(password: pass, value: conPass);
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      status: Formz.validate([confirmPassword, state.name, state.email]),
    ));
  }

  Future<void> userReg() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    RegReqModel userModel = RegReqModel(
      name: state.name.value,
      email: state.email.value,
      phone: state.number.value,
      password: state.password.value,
      deptId: int.parse(state.dept.value),
      userType: int.parse(state.userType.value),
      activation: state.userType.value == 0 ? 1 : 0,
    );
    _authRepository.userRegistrationUser(userModel).then((value) {
      RegRespModel resRespModel = RegRespModel.fromJson(value);
      if (resRespModel != null && resRespModel.success == 0) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            exceptionError: resRespModel.message));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    });
  }

  Future<List<DeptData>> getDeptType() async =>
      _authRepository.fetchDeptTypeData().then((value) {
        DeptResp companyTypesResp = DeptResp.fromJson(value);
        List<DeptData> listCompanyData =
            List<DeptData>.from(companyTypesResp.data!);
        return listCompanyData;
      });
}
