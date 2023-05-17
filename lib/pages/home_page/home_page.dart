import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../sales_page/sales_page.dart';
import '../stocks_page/stock_page.dart';
import '../suppliers_page/suppliers_page.dart';
import '../users_page/users_list.dart';
import '../../services/settings_controller.dart';

import '../damages_page/damages_page.dart';
import '../dashboard_page/dashboard_page.dart';
import '../users_page/users_main_page.dart';
import 'components/side_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SideBar(),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: IndexedStack(
          index: ref.watch(currentHomeIndex),
          children: const [
            DashboardPage(),
            UserMainPage(),
            StockPage(),
            SalesPage(),
            DamagesPage(),
            SuppliersPage()
          ],
        ),
      ))
    ]);
  }
}
