import 'package:rapid_response/validations/field_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class AddressState extends Equatable {
  const AddressState({
    this.latitude = const Field.pure(),
    this.longitude = const Field.pure(),
    this.time = const Field.pure(),
    this.uId = const Field.pure(),
    this.status = FormzStatus.pure,
    this.exceptionError = "",
  });

  final Field latitude;
  final Field longitude;
  final Field time;
  final Field uId;
  final FormzStatus status;
  final String exceptionError;

  @override
  List<Object> get props =>
      [latitude, longitude, time, uId, status, exceptionError];

  AddressState copyWith({
    Field? latitude,
    Field? longitude,
    Field? time,
    Field? uId,
    FormzStatus? status,
    String? exceptionError,
  }) {
    return AddressState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      time: time ?? this.time,
      uId: uId ?? this.uId,
      status: status ?? this.status,
      exceptionError: exceptionError ?? this.exceptionError,
    );
  }
}
