import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickchange_pos/services/user_controller.dart';
import 'package:quickchange_pos/utils/app_colors.dart';
import '../../../services/settings_controller.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var themeMode = ref.watch(themeProvider);

    return Drawer(
        width: ref.watch(sideBarWidth),
        elevation: 10,
        backgroundColor: themeMode == AdaptiveThemeMode.light
            ? Colors.white
            : secondaryColors,
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            SideBarItem(
                onTap: () {
                  if (size.width > 900) {
                    if (ref.watch(sideBarWidth) == 60) {
                      ref.read(sideBarWidth.notifier).state = 200;
                    } else {
                      ref.read(sideBarWidth.notifier).state = 60;
                    }
                  } else {
                    ref.read(sideBarWidth.notifier).state = 60;
                  }
                },
                isSelected: false,
                title: '',
                icon: Icons.menu),
            const SizedBox(
              height: 40,
            ),
            SideBarItem(
                onTap: () {
                  ref.read(currentHomeIndex.notifier).state = 0;
                },
                isSelected: ref.watch(currentHomeIndex) == 0,
                title: 'Dashboard',
                icon: Icons.apps),
            if (ref.watch(currentUserController).role!.toLowerCase() == "admin")
              SideBarItem(
                  onTap: () {
                    ref.read(currentHomeIndex.notifier).state = 1;
                  },
                  isSelected: ref.watch(currentHomeIndex) == 1,
                  title: 'Users',
                  icon: FontAwesomeIcons.users),
            SideBarItem(
                onTap: () {
                  ref.read(currentHomeIndex.notifier).state = 2;
                },
                isSelected: ref.watch(currentHomeIndex) == 2,
                title: 'Stock/Products',
                icon: FontAwesomeIcons.moneyBillTrendUp),
            SideBarItem(
                onTap: () {
                  ref.read(currentHomeIndex.notifier).state = 3;
                },
                isSelected: ref.watch(currentHomeIndex) == 3,
                title: 'Sales',
                icon: FontAwesomeIcons.cartShopping),
            SideBarItem(
                onTap: () {
                  ref.read(currentHomeIndex.notifier).state = 5;
                },
                isSelected: ref.watch(currentHomeIndex) == 5,
                title: 'Returns/Damages',
                icon: FontAwesomeIcons.personWalkingArrowLoopLeft),
            SideBarItem(
                onTap: () {
                  ref.read(currentHomeIndex.notifier).state = 4;
                },
                isSelected: ref.watch(currentHomeIndex) == 4,
                title: 'Suppliers',
                icon: FontAwesomeIcons.truckMoving),
            const Divider(
              color: Colors.white,
              thickness: 5,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Version 1.0.0',
                style: normalStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    context: context),
              ),
            ),
          ],
        ));
  }
}

class SideBarItem extends ConsumerStatefulWidget {
  const SideBarItem(
      {Key? key,
      required this.onTap,
      required this.isSelected,
      required this.title,
      required this.icon})
      : super(key: key);
  final VoidCallback onTap;
  final bool isSelected;
  final String title;
  final IconData icon;
  @override
  ConsumerState<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends ConsumerState<SideBarItem> {
  bool onHover = false;
  Color background = Colors.white;
  @override
  Widget build(BuildContext context) {
    var themeMode = ref.watch(themeProvider);
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          onHover = value;
        });
      },
      child: Container(
          height: 65,
          width: ref.watch(sideBarWidth),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: widget.isSelected
              ? themeMode == AdaptiveThemeMode.dark
                  ? Colors.white
                  : secondaryColors
              : onHover
                  ? widget.title.isNotEmpty
                      ? themeMode == AdaptiveThemeMode.dark
                          ? Colors.white.withOpacity(0.3)
                          : secondaryColors.withOpacity(0.3)
                      : Colors.transparent
                  : Colors.transparent,
          child: Row(
            mainAxisAlignment: ref.watch(sideBarWidth) == 60
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (widget.title.isEmpty && ref.watch(sideBarWidth) == 200)
                const Spacer(),
              Icon(
                widget.icon,
                color: widget.isSelected ? primaryColors : null,
              ),
              if (ref.watch(sideBarWidth) > 60)
                const SizedBox(
                  width: 20,
                ),
              if (ref.watch(sideBarWidth) > 60)
                Text(
                  widget.title,
                  style: normalStyle(
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: widget.isSelected ? primaryColors : null),
                )
            ],
          )),
    );
  }
}
