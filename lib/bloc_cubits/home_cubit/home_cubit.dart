import 'package:railway_alert/models/address_resp_model.dart';
import 'package:railway_alert/models/station_location_by_id_resp.dart';
import 'package:railway_alert/storage/cache/secure_storage_helper.dart';
import 'package:railway_alert/bloc_cubits/home_cubit/home_state.dart';
import 'package:railway_alert/repository/home_repository.dart';
import 'package:railway_alert/models/emp_resp_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeInitialState());

  HomeRepository _homeRepository;

  Future getUser(String value) async {
    emit(const HomeLoading());
    _homeRepository.fetchEmployeeData(value).then((value) {
      EmpResp empResp = EmpResp.fromJson(value);
      List<EmpData> empData = List<EmpData>.from(empResp.data!);
      if (empResp != null && empResp.success == 1) {
        emit(HomeSuccess(message: "data found", countData: empData));
      } else {
        emit(const HomeFailure(errorMessage: 'data not found'));
      }
    });
  }

  Future getAdminUser(String value) async {
    emit(const HomeLoading());
    _homeRepository.fetchAdminData(value).then((value) {
      EmpResp empResp = EmpResp.fromJson(value);
      List<EmpData> empData = List<EmpData>.from(empResp.data!);
      if (empResp != null && empResp.success == 1) {
        emit(HomeSuccess(message: "data found", countData: empData));
      } else {
        emit(const HomeFailure(errorMessage: 'data not found'));
      }
    });
  }

  Future getUserLocation(int value) async {
    emit(const HomeLoading());
    _homeRepository.fetchEmployeeLocationData(value).then((value) {
      AddressResp addressResp = AddressResp.fromJson(value);
      List<AddressData> addressData = List<AddressData>.from(addressResp.data!);
      if (addressResp != null && addressResp.success == 1) {
        emit(HomeDetailSuccess(message: "data found", countData: addressData));
      } else {
        emit(const HomeFailure(errorMessage: 'data not found'));
      }
    });
  }

  Future updateActivation(int userId) async {
    emit(const HomeLoading());
    _homeRepository.activeActivation(userId);
  }

  Future dUpdateActivation(int userId) async {
    emit(const HomeLoading());
    _homeRepository.dActiveActivation(userId);
  }

  Future logout() async {
    await SecStore.deleteAll();
  }

  Future callSMSAPI(String smsURL) async {
    _homeRepository.smsAPI(smsURL);
  }

  Future<List<StationLocationData>> getStationLocation(value) async =>
      _homeRepository.getStationLocationById(value).then((value) {
        StationLocationByIdResp companyTypesResp =
            StationLocationByIdResp.fromJson(value);
        List<StationLocationData> listCompanyData =
            List<StationLocationData>.from(companyTypesResp.data!);
        return listCompanyData;
      });
}
