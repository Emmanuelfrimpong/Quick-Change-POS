import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/settings_model/settings_model.dart';
import 'hive_services.dart';
import 'package:intl/intl.dart';

final settingsController =
    StateNotifierProvider<SettingsController, SettingsModel>((ref) {
  return SettingsController();
});

class SettingsController extends StateNotifier<SettingsModel> {
  SettingsController() : super(HiveServices.getSettings());
  void updateSettings() {
    state = HiveServices.getSettings();
  }

  void updateFields(
      {String? companyName,
      String? companyDescription,
      String? companyPhone,
      String? companyLocation,
      String? companyEmail,
      String? logo}) {
    state.companyName = companyName;
    state.companyDescription = companyDescription;
    state.companyLogo = logo;
    state.email = companyEmail;
    state.location = companyLocation;
    state.telephone = companyPhone;
  }

  void saveSettings() {
    HiveServices.setSettings(state);
    //let update state
    updateSettings();
  }
}

//create a stream provider that will return a timer that will update every second
final timerProvider = StreamProvider<String>((ref) {
  return Stream.periodic(
      const Duration(seconds: 1),
      (string) => DateFormat('EEEE, MMM d yyyy - HH:mm:ss a')
          .format(DateTime.now().toUtc()));
});

// create a provider that will check if the settings exist in hive
// if it does return true else return false
final settingsExist = StateProvider((ref) {
  bool exist = HiveServices.settingsExist();
  return exist;
});
// create a provider to check user Authentication status

final authStatus = StateNotifierProvider<AuthStatus, int>((ref) {
  return AuthStatus();
});

class AuthStatus extends StateNotifier<int> {
  AuthStatus() : super(HiveServices.getLoginStatus() ? 0 : 1);
  void updateAuthStatus(bool status) {
    HiveServices.setLoginStatus(status);
    state = HiveServices.getLoginStatus() ? 0 : 1;
  }
}

//create a provider to check the selected theme
final themeProvider =
    StateNotifierProvider<ThemeProvider, AdaptiveThemeMode>((ref) {
  return ThemeProvider();
});

class ThemeProvider extends StateNotifier<AdaptiveThemeMode> {
  ThemeProvider() : super(HiveServices.getTheme());
  void updateTheme(BuildContext context) {
    // check the current theme and update it
    if (AdaptiveTheme.of(context).mode.isDark) {
      state = AdaptiveThemeMode.light;
    } else {
      state = AdaptiveThemeMode.dark;
    }
    HiveServices.setTheme(state);
    AdaptiveTheme.of(context).setThemeMode(state);
  }
}

// create a provider to check the current settings page index
final settingsPageIndex = StateProvider<int>((ref) {
  return 0;
});

final sideBarWidth = StateProvider<double>((ref) {
  return 60;
});

final currentHomeIndex = StateProvider<int>((ref) {
  return 0;
});
