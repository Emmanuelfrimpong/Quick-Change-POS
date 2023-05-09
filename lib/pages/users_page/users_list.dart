import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quickchange_pos/core/widgets/custom_button.dart';
import 'package:quickchange_pos/core/widgets/custom_input.dart';
import 'package:quickchange_pos/generated/assets.dart';
import 'package:quickchange_pos/utils/app_colors.dart';
import 'package:responsive_table/responsive_table.dart';
import '../../core/widgets/title_text.dart';
import '../../services/page_navigation_controller.dart';
import '../../services/user_controller.dart';

class UsersList extends ConsumerWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentUser = ref.watch(currentUserController);
    var isSearching = ref.watch(isSearchingProvider);
    var size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(0),
        constraints: const BoxConstraints(
          maxHeight: 1000,
        ),
        child: Card(
            elevation: 10,
            shadowColor: Colors.black,
            clipBehavior: Clip.none,
            child: ResponsiveDatatable(
              onTabRow: (data) {
                // open user details dialog
              },
              title: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: titleText(context, 'Users', fontSize: 40),
              ),
              actions: [
                const Spacer(),
                //create search bar if isSearching is true
                if (isSearching)
                  SizedBox(
                    width: size.width > 900 ? 700 : 500,
                    child: CustomTextFields(
                      hintText: "Search user",
                      onChanged: (value) {
                        ref.read(queryStringProvider.notifier).state = value;
                      },
                    ),
                  ),
                IconButton(
                    onPressed: () {
                      ref.read(isSearchingProvider.notifier).state =
                          !isSearching;
                    },
                    icon: Icon(
                      isSearching ? Icons.close : Icons.search,
                      color: primaryColors,
                    )),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  onPressed: () => {
                    //go to new user page
                    ref.read(userPageIndexProvider.notifier).state = 1
                  },
                  icon: Icons.add,
                  text: "New User",
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
              headerTextStyle: normalStyle(
                  context: context, fontSize: 18, fontWeight: FontWeight.w600),
              reponseScreenSizes: const [
                ScreenSize.xs,
                ScreenSize.sm,
                //ScreenSize.md,
                // ScreenSize.lg
              ],
              source: ref.watch(filteredUsersToMapProvider),
              selecteds: [],
              expanded: [false],
              headers: [
                DatatableHeader(
                  text: "Image",
                  value: "profile",
                  show: true,
                  sortable: false,
                  textAlign: TextAlign.center,
                  sourceBuilder: (value, row) {
                    if (value != null) {
                      return Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: MemoryImage(value),
                                fit: BoxFit.contain)),
                      );
                    } else {
                      return Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(Assets.imagesUser),
                                fit: BoxFit.contain)),
                      );
                    }
                  },
                ),
                DatatableHeader(
                    text: "ID",
                    value: "userId",
                    show: true,
                    sortable: true,
                    textAlign: TextAlign.center),
                DatatableHeader(
                    text: "Name",
                    value: "username",
                    show: true,
                    sortable: true,
                    textAlign: TextAlign.center),
                DatatableHeader(
                    text: "Role",
                    value: "role",
                    show: true,
                    sortable: true,
                    textAlign: TextAlign.center),
                DatatableHeader(
                    text: "Phone",
                    value: "phone",
                    show: true,
                    sortable: true,
                    textAlign: TextAlign.center),
                DatatableHeader(
                    text: "Last Login",
                    value: "lastLogin",
                    show: true,
                    sortable: true,
                    textAlign: TextAlign.center,
                    sourceBuilder: (value, row) {
                      final f = DateFormat('MMM dd,yyyy hh:mm a');
                      return Text(
                        value == null
                            ? "Never"
                            : f.format(
                                DateTime.fromMillisecondsSinceEpoch(value)),
                        textAlign: TextAlign.center,
                      );
                    }),
                DatatableHeader(
                    text: "Action",
                    value: "userId",
                    show: true,
                    sortable: false,
                    textAlign: TextAlign.center,
                    sourceBuilder: (value, row) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: primaryColors),
                            onPressed: () => {
                              //go to edit user page
                              ref.read(currentUserProvider.notifier).state = ref
                                  .watch(userController)
                                  .firstWhere(
                                      (element) => element.userId == value),
                              ref.read(userPageIndexProvider.notifier).state = 2
                            },
                          ),
                          const SizedBox(width: 10),
                          //check if the user is the current user
                          if (currentUser.role!.toLowerCase() == "admin" &&
                              currentUser.userId != value)
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => {},
                            ),
                          if (currentUser.role!.toLowerCase() == "admin" &&
                              currentUser.userId == value)
                            const SizedBox(
                              width: 50,
                            )
                        ],
                      );
                    }),
              ],
            )));
  }
}
