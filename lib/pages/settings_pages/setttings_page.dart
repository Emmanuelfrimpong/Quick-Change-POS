import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickchange_pos/pages/settings_pages/admin_info.dart';
import 'package:quickchange_pos/pages/settings_pages/company_info.dart';

import '../../services/settings_controller.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        child: IndexedStack(
          alignment: Alignment.center,
          index: ref.watch(settingsPageIndex),
          children: const [
            CompanyInfoPage(),
            AdministratorInfoPage(),
          ],
        ));
  }
}
