import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickchange_pos/core/widgets/custom_button.dart';

import '../../core/widgets/title_text.dart';

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleText(context, 'Users', fontSize: 50),
                CustomButton(
                    text: 'New User', onPressed: () {}, icon: Icons.add)
              ],
            ),
          ),
          const Divider(
            thickness: 5,
            height: 30,
          )
        ],
      ),
    );
  }
}
