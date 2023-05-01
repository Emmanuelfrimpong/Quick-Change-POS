import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickchange_pos/pages/sales_page/sales_page.dart';
import 'package:quickchange_pos/pages/stocks_page/stock_page.dart';
import 'package:quickchange_pos/pages/suppliers_page/suppliers_page.dart';
import 'package:quickchange_pos/pages/users_page/user_page.dart';
import 'package:quickchange_pos/services/settings_controller.dart';

import '../damages_page/damages_page.dart';
import '../dashboard_page/dashboard_page.dart';
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
            UsersPage(),
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
