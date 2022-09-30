import 'package:rapid_response/models/dept_resp_model.dart';
import 'package:rapid_response/models/division_resp.dart';
import 'package:rapid_response/models/railway_resp_model.dart';
import 'package:rapid_response/models/reg_resp_model.dart';
import 'package:rapid_response/models/zone_resp.dart';
import 'package:rapid_response/validations/confirm_password_validation.dart';
import 'package:rapid_response/validations/number_validation_dart.dart';
import 'package:rapid_response/bloc_cubits/reg_cubit/reg_state.dart';
import 'package:rapid_response/validations/password_validation.dart';
import 'package:rapid_response/validations/email_validation.dart';
import 'package:rapid_response/validations/field_validation.dart';
import 'package:rapid_response/validations/name_validation.dart';
import 'package:rapid_response/repository/auth_repository.dart';
import 'package:rapid_response/validations/dob_validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_response/models/reg_req_model.dart';
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

  void railwayChanged(int value) {
    final railway = Field.dirty(value.toString());
    emit(state.copyWith(
      railway: railway,
      status: Formz.validate([railway, state.email, state.password]),
    ));
  }

  void zoneChanged(int value) {
    final zone = Field.dirty(value.toString());
    emit(state.copyWith(
      zone: zone,
      status: Formz.validate([zone, state.email, state.password]),
    ));
  }

  void divisionChanged(int value) {
    final division = Field.dirty(value.toString());
    emit(state.copyWith(
      division: division,
      status: Formz.validate([division, state.email, state.password]),
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

  Future<List<RailwayData>> getRailwayType() async =>
      _authRepository.fetchRailwayData().then((value) {
        RailwayResp railwayResp = RailwayResp.fromJson(value);
        List<RailwayData> listCompanyData =
            List<RailwayData>.from(railwayResp.data!);
        return listCompanyData;
      });

  Future<List<ZoneData>> getZoneType(selectedId) async =>
      _authRepository.fetchZoneData(selectedId).then((value) {
        ZoneResp zoneResp = ZoneResp.fromJson(value);
        List<ZoneData> listCompanyData =
            List<ZoneData>.from(zoneResp.data!);
        return listCompanyData;
      });

  Future<List<DivisionData>> getDivision(selectedId) async =>
      _authRepository.fetchDivisionData(selectedId).then((value) {
        DivisionResp zoneResp = DivisionResp.fromJson(value);
        List<DivisionData> listCompanyData =
            List<DivisionData>.from(zoneResp.data!);
        return listCompanyData;
      });

  Future<List<DeptData>> getDeptType(selectedId) async =>
      _authRepository.fetchDeptTypeData(selectedId).then((value) {
        DeptResp companyTypesResp = DeptResp.fromJson(value);
        List<DeptData> listCompanyData =
            List<DeptData>.from(companyTypesResp.data!);
        return listCompanyData;
      });
}
