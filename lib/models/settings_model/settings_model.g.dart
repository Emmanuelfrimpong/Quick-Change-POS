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
      companyLogo: fields[1] as String?,
      companyName: fields[2] as String?,
      slogan: fields[3] as String?,
      location: fields[4] as String?,
      telephone: fields[5] as String?,
      email: fields[6] as String?,
      themeType: fields[7] as String?,
      primaryColor: fields[8] as Color?,
      secondaryColor: fields[9] as Color?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.language)
      ..writeByte(1)
      ..write(obj.companyLogo)
      ..writeByte(2)
      ..write(obj.companyName)
      ..writeByte(3)
      ..write(obj.slogan)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.telephone)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.themeType)
      ..writeByte(8)
      ..write(obj.primaryColor)
      ..writeByte(9)
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
