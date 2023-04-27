// ignore_for_file: public_member_api_docs, sort_constructors_first
//here a create a hive object for settings
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 0)
class SettingsModel {
  @HiveField(0)
  String? language;
  @HiveField(1)
  String? companyLogo;
  @HiveField(2)
  String? companyName;
  @HiveField(3)
  String? slogan;
  @HiveField(4)
  String? location;
  @HiveField(5)
  String? telephone;
  @HiveField(6)
  String? email;
  @HiveField(7)
  String? themeType;
  @HiveField(8)
  Color? primaryColor;
  @HiveField(9)
  Color? secondaryColor;

  SettingsModel({
    this.language,
    this.companyLogo,
    this.companyName,
    this.slogan,
    this.location,
    this.telephone,
    this.email,
    this.themeType,
    this.primaryColor,
    this.secondaryColor,
  });

}


 