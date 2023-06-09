import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/settings_model/settings_model.dart';

import '../models/user_model/user_model.dart';

class HiveServices {
  static Future<void> init() async {
    String path = Directory('${Directory.current.path}/Database').path;
    final collection = await BoxCollection.open(
      'Database', // Name of your database
      {'core'}, // Names of your boxes
      path: path,
    );
    // Open your boxes. Optional: Give it a type.
    final core = collection.openBox('core');
  }

//get and set settings
  static SettingsModel getSettings() {
    var box = Hive.box<SettingsModel>('settings');
    return box.get('settings', defaultValue: SettingsModel.defaultSettings())!;
  }

  static void setSettings(SettingsModel settings) {
    var box = Hive.box<SettingsModel>('settings');
    box.put('settings', settings);
  }

  static bool settingsExist() {
    var box = Hive.box<SettingsModel>('settings');
    print('key from hive ${box.containsKey('settings')}');
    return box.containsKey('settings');
  }

  //set user login status
  static void setLoginStatus(bool status) {
    var box = Hive.box('core');
    box.put('loginStatus', status);
  }

  //now let get the status of the logon and return false by default
  static bool getLoginStatus() {
    var box = Hive.box('core');
    return box.get('loginStatus', defaultValue: false);
  }

  //set and get the selected theme
  static void setTheme(AdaptiveThemeMode mode) {
    var box = Hive.box('core');
    box.put('theme', mode.name);
  }

  static AdaptiveThemeMode getTheme() {
    var box = Hive.box('core');
    var theme = box.get('theme', defaultValue: 'light');
    if (theme == 'light') {
      return AdaptiveThemeMode.light;
    } else {
      return AdaptiveThemeMode.dark;
    }
  }

  //create a set user and get user with default value
  static void setUser(UserModel user) {
    var box = Hive.box<UserModel>('users');
    box.put(user.userId, user);
    //refresh the user list
  }

//get a single user by id
  static UserModel getUser(String userId) {
    var box = Hive.box<UserModel>('users');
    return box.get(userId, defaultValue: UserModel.defaultUser())!;
  }

  // get all users saved in the database
  static List<UserModel> getUsers() {
    var box = Hive.box<UserModel>('users');
    return box.values.toList();
  }

//delete user from the database
  static void deleteUser(UserModel userModel) {
    var box = Hive.box<UserModel>('users');
    box.delete(userModel.userId);
  }

//get current user id
  static String getCurrentUser() {
    var box = Hive.box('core');
    return box.get('currentUser', defaultValue: '')!;
  }

  //set current user
  static void setCurrentUser(String userId) {
    var box = Hive.box('core');
    box.put('currentUser', userId);
  }

  //remove current user
  static void removeCurrentUser() {
    var box = Hive.box('core');
    box.delete('currentUser');
  }

  //create a stream to listen to user changes in the database
  static Stream<List<UserModel>> getUsersStream() {
    var box = Hive.box<UserModel>('users');
    return box.watch().map((event) => event.value.toList());
  }

  static void deleteAllUsers(String currentUserId) {
    var box = Hive.box<UserModel>('users');
    //delete all users except the current user
    box.values
        .where((element) => element.userId != currentUserId)
        .toList()
        .forEach((element) {
      box.delete(element.userId);
    });
  }

  static watchUsers() {
    var box = Hive.box<UserModel>('users');
    return box.watch();
  }
}
