import 'dart:math';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:quickchange_pos/core/functions/global_functions.dart';
import 'package:quickchange_pos/models/user_model/user_model.dart';
import 'package:quickchange_pos/pages/init_page/init_page.dart';
import 'package:quickchange_pos/services/hive_services.dart';
import 'package:quickchange_pos/services/user_controller.dart';
import 'package:quickchange_pos/utils/app_colors.dart';
import 'package:window_manager/window_manager.dart';

import 'services/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveServices.init();
  await windowManager.ensureInitialized();
  await windowManager.maximize();
  WindowOptions windowOptions = const WindowOptions(
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    minimumSize: Size(900, 700),
    titleBarStyle: TitleBarStyle.hidden,
    fullScreen: false,
  );
  //save dummy users

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: MyApp()));
  doWhenWindowReady(() {
    const initialSize = Size(900, 700);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.maximize();
    appWindow.show();
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var roles = ['Admin', 'Sales', 'Manager'];
    var states = ['Active', 'Inactive'];
    final _random = Random();
    final _random1 = Random();
    //get current company
    final company = ref.watch(settingsController).companyName;
    //get current user
    // final user = ref.watch(currentUserController);
    // //delete all users from database exept current user
    // HiveServices.deleteAllUsers(user.userId!);
    // //restart the user controller
    // ref.invalidate(userController);
    // for (var element in userData) {
    //   String id = generateID(ref);
    //   UserModel userModel = UserModel()
    //     ..userId = id
    //     ..state = states[_random1.nextInt(2)]
    //     ..password = element['password'].toString()
    //     ..secretQuestion1 = null
    //     ..secretQuestion2 = null
    //     ..secretAnswer1 = null
    //     ..secretAnswer2 = null
    //     //randomly assign role
    //     ..role = roles[_random.nextInt(roles.length)]
    //     ..createdAt = DateTime.now().toUtc().millisecondsSinceEpoch
    //     ..company = company
    //     ..username = element['username']
    //     ..phone = element['phone'];
    //   //delete user if it exists
    //   HiveServices.deleteUser(userModel);
    //   //save user
    //   HiveServices.setUser(userModel);
    // }
    // ref.invalidate(userController);
    return AdaptiveTheme(
      light: kLightTheme,
      dark: kDarkTheme,
      initial: ref.watch(themeProvider),
      builder: (theme, darkTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown
            },
          ),
          title: 'Quick Change POS',
          theme: theme,
          darkTheme: darkTheme,
          builder: FlutterSmartDialog.init(),
          home: const InitialPage()),
    );
  }
}
