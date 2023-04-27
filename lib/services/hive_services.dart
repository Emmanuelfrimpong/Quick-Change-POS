import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:quickchange_pos/models/settings_model/settings_model.dart';

class HiveServices {
  static Future<void> init() async {
    String path = Directory('${Directory.current.path}/Database').path;
    await Hive.initFlutter(path);
    Hive.registerAdapter(SettingsModelAdapter());
    await Hive.openBox<SettingsModel>('settings');
  }

//get and set settings
  static SettingsModel? getSettings() {
    var box = Hive.box<SettingsModel>('settings');
    return box.get('settings');
  }

  static void setSettings(SettingsModel settings) {
    var box = Hive.box<SettingsModel>('settings');
    box.put('settings', settings);
  }

  //
}
