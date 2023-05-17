import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'edit_user_page.dart';
import 'users_list.dart';

import '../../services/page_navigation_controller.dart';
import 'new_user.dart';

class UserMainPage extends ConsumerWidget {
  const UserMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (ref.watch(userPageIndexProvider)) {
      case 0:
        return const UsersList();
      case 1:
        return const NewUsers();
      case 2:
        return const EditUserPage();
      default:
        return const UsersList();
    }
  }
}
