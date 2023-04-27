import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickchange_pos/pages/auth_page/forgot_password.dart';
import 'package:quickchange_pos/pages/auth_page/login_page.dart';
import 'package:quickchange_pos/pages/auth_page/new_user_setup.dart';
import 'package:quickchange_pos/pages/home_page/home_page.dart';
import 'package:quickchange_pos/pages/settings_pages/setttings_page.dart';
import 'package:quickchange_pos/utils/app_colors.dart';

import '../../core/widgets/action_controls.dart';
import '../../services/settings_controller.dart';

class InitialPage extends ConsumerStatefulWidget {
  const InitialPage({Key? key}) : super(key: key);
  @override
  ConsumerState<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends ConsumerState<InitialPage> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
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
                  color: ref.watch(themeProvider).isDark && isHover
                      ? secondaryColors
                      : AdaptiveTheme.of(context).theme.scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
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
                          child: IconButton(
                              padding: const EdgeInsets.all(0),
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                ref
                                    .read(themeProvider.notifier)
                                    .updateTheme(context);
                              },
                              icon: Icon(
                                AdaptiveTheme.of(context).mode.isDark
                                    ? Icons.wb_sunny
                                    : Icons.nightlight_round,
                                size: 16,
                              )),
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
                        NewUserPage(),
                        ForgotPasswordPage()
                      ],
                    )
                  : const SettingsPage(),
            ),
          )
        ],
      ),
    );
  }
}
