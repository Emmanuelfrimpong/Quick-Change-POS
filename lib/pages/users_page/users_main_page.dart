import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickchange_pos/pages/users_page/edit_user_page.dart';
import 'package:quickchange_pos/pages/users_page/users_list.dart';

import '../../services/page_navigation_controller.dart';
import 'new_user.dart';

class UserMainPage extends ConsumerWidget {
  const UserMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IndexedStack(
      index: ref.watch(userPageIndexProvider),
      children: const [UsersList(), NewUsers(), EditUserPage()],
    );
  }
}
