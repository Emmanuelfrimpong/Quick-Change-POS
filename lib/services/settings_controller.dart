import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/settings_model/settings_model.dart';
import 'hive_services.dart';
import 'package:intl/intl.dart';

final settingsController =
    StateNotifierProvider<SettingsController, SettingsModel?>((ref) {
  return SettingsController();
});

class SettingsController extends StateNotifier<SettingsModel?> {
  SettingsController() : super(HiveServices.getSettings());
  void updateSettings() {
    state = HiveServices.getSettings();
  }
}

//create a stream provider that will return a timer that will update every second
final timerProvider = StreamProvider<String>((ref) {
  return Stream.periodic(
      const Duration(seconds: 1),
      (String) => DateFormat('EEEE, MMM d yyyy - HH:mm:ss a')
          .format(DateTime.now().toUtc()));
});

// create a provider that will check if the settings exist in hive
// if it does return true else return false

final settingsExist = StateProvider((ref) =>
    HiveServices.getSettings() != null &&
    HiveServices.getSettings()!.companyName != null);
