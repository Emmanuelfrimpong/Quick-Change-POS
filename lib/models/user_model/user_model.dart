// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

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
  String? secretAnswer1;
  @HiveField(10)
  String? secretAnswer2;
  @HiveField(11)
  int? createdAt;
  @HiveField(12)
  String? company;
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
    this.secretAnswer1,
    this.secretAnswer2,
    this.createdAt,
    this.company,
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
      secretAnswer1: null,
      secretAnswer2: null,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      company: null,
    );
  }

  //create a bool to check if user is default
  bool get isDefault => userId == null;

  //userModel to json

  UserModel copyWith({
    String? userId,
    String? username,
    String? password,
    String? phone,
    int? lastLogin,
    String? role,
    Uint8List? profile,
    String? secretQuestion1,
    String? secretQuestion2,
    String? secretAnswer1,
    String? secretAnswer2,
    int? createdAt,
    String? company,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      lastLogin: lastLogin ?? this.lastLogin,
      role: role ?? this.role,
      profile: profile ?? this.profile,
      secretQuestion1: secretQuestion1 ?? this.secretQuestion1,
      secretQuestion2: secretQuestion2 ?? this.secretQuestion2,
      secretAnswer1: secretAnswer1 ?? this.secretAnswer1,
      secretAnswer2: secretAnswer2 ?? this.secretAnswer2,
      createdAt: createdAt ?? this.createdAt,
      company: company ?? this.company,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'password': password,
      'phone': phone,
      'lastLogin': lastLogin,
      'role': role,
      'profile': profile,
      'secretQuestion1': secretQuestion1,
      'secretQuestion2': secretQuestion2,
      'secretAnswer1': secretAnswer1,
      'secretAnswer2': secretAnswer2,
      'createdAt': createdAt,
      'company': company,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      lastLogin: map['lastLogin'] != null ? map['lastLogin'] as int : null,
      role: map['role'] != null ? map['role'] as String : null,
      profile: map['profile'] != null ? map['profile'] as Uint8List : null,
      secretQuestion1: map['secretQuestion1'] != null
          ? map['secretQuestion1'] as String
          : null,
      secretQuestion2: map['secretQuestion2'] != null
          ? map['secretQuestion2'] as String
          : null,
      secretAnswer1:
          map['secretAnswer1'] != null ? map['secretAnswer1'] as String : null,
      secretAnswer2:
          map['secretAnswer2'] != null ? map['secretAnswer2'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
      company: map['company'] != null ? map['company'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userId: $userId, username: $username, password: $password, phone: $phone, lastLogin: $lastLogin, role: $role, profile: $profile, secretQuestion1: $secretQuestion1, secretQuestion2: $secretQuestion2, secretAnswer1: $secretAnswer1, secretAnswer2: $secretAnswer2, createdAt: $createdAt, company: $company)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.username == username &&
        other.password == password &&
        other.phone == phone &&
        other.lastLogin == lastLogin &&
        other.role == role &&
        other.profile == profile &&
        other.secretQuestion1 == secretQuestion1 &&
        other.secretQuestion2 == secretQuestion2 &&
        other.secretAnswer1 == secretAnswer1 &&
        other.secretAnswer2 == secretAnswer2 &&
        other.createdAt == createdAt &&
        other.company == company;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        username.hashCode ^
        password.hashCode ^
        phone.hashCode ^
        lastLogin.hashCode ^
        role.hashCode ^
        profile.hashCode ^
        secretQuestion1.hashCode ^
        secretQuestion2.hashCode ^
        secretAnswer1.hashCode ^
        secretAnswer2.hashCode ^
        createdAt.hashCode ^
        company.hashCode;
  }
}
