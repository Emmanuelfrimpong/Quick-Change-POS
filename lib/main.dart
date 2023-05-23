import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'pages/init_page/init_page.dart';
import 'services/hive_services.dart';
import 'utils/app_colors.dart';
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

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: MyApp()));

}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
