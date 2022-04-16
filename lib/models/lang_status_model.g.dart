// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lang_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LangsStatusAdapter extends TypeAdapter<LangsStatus> {
  @override
  final int typeId = 2;

  @override
  LangsStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LangsStatus(
      fields[0] as bool,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LangsStatus obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isSelected)
      ..writeByte(1)
      ..write(obj.buttonText)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.subtitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LangsStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
