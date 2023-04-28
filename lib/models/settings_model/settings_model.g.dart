// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 0;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      language: fields[0] as String?,
      companyLogo: fields[1] as Uint8List?,
      companyName: fields[2] as String?,
      companyDescription: fields[3] as String?,
      location: fields[4] as String?,
      telephone: fields[5] as String?,
      email: fields[6] as String?,
      primaryColor: fields[7] as Color?,
      secondaryColor: fields[8] as Color?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.language)
      ..writeByte(1)
      ..write(obj.companyLogo)
      ..writeByte(2)
      ..write(obj.companyName)
      ..writeByte(3)
      ..write(obj.companyDescription)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.telephone)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.primaryColor)
      ..writeByte(8)
      ..write(obj.secondaryColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
