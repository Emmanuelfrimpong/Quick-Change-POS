import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickchange_pos/pages/auth_page/login_page.dart';
import 'package:quickchange_pos/pages/home_page/home_page.dart';
import 'package:quickchange_pos/pages/settings_pages/setttings_page.dart';
import 'package:quickchange_pos/services/hive_services.dart';
import 'package:quickchange_pos/services/user_controller.dart';
import 'package:quickchange_pos/utils/app_colors.dart';
import 'package:window_manager/window_manager.dart';

import '../../core/widgets/action_controls.dart';
import '../../services/settings_controller.dart';

class InitialPage extends ConsumerStatefulWidget {
  const InitialPage({Key? key}) : super(key: key);
  @override
  ConsumerState<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends ConsumerState<InitialPage> with WindowListener {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    var themeMode = ref.watch(themeProvider);
    var theme = AdaptiveTheme.of(context).theme;
    var status = ref.watch(authStatus);
    // HiveServices.setLoginStatus(false);
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: MoveWindow(
              child: InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    isHover = value;
                  });
                },
                child: Card(
                  elevation: isHover ? 5 : 0,
                  color: themeMode.isDark && isHover
                      ? secondaryColors
                      : theme.scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        if (status == 0)
                          //create a user Profile
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.transparent,
                            backgroundImage: MemoryImage(
                                ref.watch(currentUserController).profile!),
                          ),
                        const SizedBox(width: 10),
                        if (status == 0)
                          //show username and role
                          Text(
                            '${ref.watch(currentUserController).username!}(${ref.watch(currentUserController).role!})',
                            style: normalStyle(
                                context: context,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ref.watch(timerProvider).value ?? '',
                                style: normalStyle(
                                    context: context,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(themeProvider.notifier)
                                  .updateTheme(context);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: themeMode.isDark
                                      ? Colors.white.withOpacity(.3)
                                      : Colors.black.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Icon(
                                themeMode.isDark
                                    ? Icons.wb_sunny
                                    : Icons.nightlight_round,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        const SizedBox(width: 100, child: ActionControls()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: ref.watch(settingsExist)
                  ? IndexedStack(
                      alignment: Alignment.center,
                      index: ref.watch(authStatus),
                      children: const [
                        HomePage(),
                        LoginPage(),
                      ],
                    )
                  : const SettingsPage(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowResized() {
    super.onWindowResized();
    WindowManager.instance.getSize().then((value) {
      if (value.width < 1000) {
        ref.read(sideBarWidth.notifier).state = 60;
      }
    });
  }

  @override
  void onWindowUnmaximize() {
    WindowManager.instance.getSize().then((value) {
      if (value.width < 1000) {
        ref.read(sideBarWidth.notifier).state = 60;
      }
    });
  }
}
