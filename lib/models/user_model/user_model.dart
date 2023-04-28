// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  String? userId;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? password;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  int? lastLogin;
  @HiveField(5)
  String? role;
  @HiveField(6)
  Uint8List? profile;
  @HiveField(7)
  String? secretQuestion1;
  @HiveField(8)
  String? secretQuestion2;
  @HiveField(9)
  String? secretQuestion3;
  @HiveField(10)
  String? secretAnswer1;
  @HiveField(11)
  String? secretAnswer2;
  @HiveField(12)
  String? secretAnswer3;
  @HiveField(13)
  int? createdAt;
  UserModel({
    this.userId,
    this.username,
    this.password,
    this.phone,
    this.lastLogin,
    this.role,
    this.profile,
    this.secretQuestion1,
    this.secretQuestion2,
    this.secretQuestion3,
    this.secretAnswer1,
    this.secretAnswer2,
    this.secretAnswer3,
    this.createdAt,
  });

  //create a default user
  static UserModel defaultUser() {
    return UserModel(
      userId: null,
      username: null,
      password: null,
      phone: null,
      lastLogin: null,
      role: null,
      profile: null,
      secretQuestion1: null,
      secretQuestion2: null,
      secretQuestion3: null,
      secretAnswer1: null,
      secretAnswer2: null,
      secretAnswer3: null,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  //create a bool to check if user is default
  bool get isDefault => this == defaultUser();
}
