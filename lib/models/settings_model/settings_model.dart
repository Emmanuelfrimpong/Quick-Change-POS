// ignore_for_file: public_member_api_docs, sort_constructors_first
//here a create a hive object for settings
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 0)
class SettingsModel {
  @HiveField(0)
  String? language;
  @HiveField(1)
  Uint8List? companyLogo;
  @HiveField(2)
  String? companyName;
  @HiveField(3)
  String? companyDescription;
  @HiveField(4)
  String? location;
  @HiveField(5)
  String? telephone;
  @HiveField(6)
  String? email;
  @HiveField(7)
  Color? primaryColor;
  @HiveField(8)
  Color? secondaryColor;
  @HiveField(9)
  int? createdAt;

  SettingsModel({
    this.language,
    this.companyLogo,
    this.companyName,
    this.companyDescription,
    this.location,
    this.telephone,
    this.email,
    this.primaryColor,
    this.secondaryColor,
    this.createdAt,
  });

  //create a default settings
  static SettingsModel defaultSettings() {
    return SettingsModel(
      language: 'en',
      companyLogo: null,
      companyName: null,
      companyDescription: null,
      location: null,
      telephone: null,
      email: null,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  //create a bool to check if settings is default
  bool get isDefault => companyName == null;
}
