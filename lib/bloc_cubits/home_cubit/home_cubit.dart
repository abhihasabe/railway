import 'package:railway_alert/bloc_cubits/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railway_alert/models/emp_resp_model.dart';
import 'package:railway_alert/repository/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeInitialState());

  HomeRepository _homeRepository;

  Future getUser(int value) async {
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
}
