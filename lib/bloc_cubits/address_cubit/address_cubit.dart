import 'package:formz/formz.dart';
import 'package:railway_alert/bloc_cubits/address_cubit/address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railway_alert/models/add_address_req_model.dart';
import 'package:railway_alert/repository/address_repository.dart';
import 'package:railway_alert/validations/field_validation.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this._addressRepository) : super(const AddressState());

  AddressRepository _addressRepository;

  void latitudeChanged(String value) {
    final latitude = Field.dirty(value);
    emit(state.copyWith(
      latitude: latitude,
      status: Formz.validate([latitude]),
    ));
  }

  void longitudeChanged(String value) {
    final longitude = Field.dirty(value);
    emit(state.copyWith(
      longitude: longitude,
      status: Formz.validate([longitude]),
    ));
  }

  void timeChanged(String value) {
    final time = Field.dirty(value);
    emit(state.copyWith(
      time: time,
      status: Formz.validate([time]),
    ));
  }

  void userIdChanged(String value) {
    final uId = Field.dirty(value);
    emit(state.copyWith(
      uId: uId,
      status: Formz.validate([uId]),
    ));
  }

  Future addAddress(String latitude, String longitude, String time, id) async {
    print("addressResp $latitude");
    AddAddressReq addressResp = AddAddressReq(
        latitude: latitude,
        longitude: longitude,
        time: time,
        eId: id);
    _addressRepository.addressData(addressResp);
  }
}
