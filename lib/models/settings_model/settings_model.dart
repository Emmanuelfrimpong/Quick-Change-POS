
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';


class SettingsModel {

  String? language;
  String? companyLogo;
  String? companyName;
  String? companyDescription;
  String? location;
  String? telephone;
  String? email;
  Color? primaryColor;
  Color? secondaryColor;
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
