// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      userId: fields[0] as String?,
      username: fields[1] as String?,
      password: fields[2] as String?,
      phone: fields[3] as String?,
      lastLogin: fields[4] as int?,
      role: fields[5] as String?,
      profile: fields[6] as Uint8List?,
      secretQuestion1: fields[7] as String?,
      secretQuestion2: fields[8] as String?,
      secretAnswer1: fields[9] as String?,
      secretAnswer2: fields[10] as String?,
      createdAt: fields[11] as int?,
      company: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.lastLogin)
      ..writeByte(5)
      ..write(obj.role)
      ..writeByte(6)
      ..write(obj.profile)
      ..writeByte(7)
      ..write(obj.secretQuestion1)
      ..writeByte(8)
      ..write(obj.secretQuestion2)
      ..writeByte(9)
      ..write(obj.secretAnswer1)
      ..writeByte(10)
      ..write(obj.secretAnswer2)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.company);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
