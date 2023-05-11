import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickchange_pos/core/widgets/custom_button.dart';
import 'package:quickchange_pos/core/widgets/custom_input.dart';
import 'package:quickchange_pos/core/widgets/smart_dialog.dart';
import 'package:quickchange_pos/generated/assets.dart';
import 'package:quickchange_pos/utils/app_colors.dart';
import 'package:responsive_table/responsive_table.dart';
import '../../core/widgets/title_text.dart';
import '../../services/page_navigation_controller.dart';
import '../../services/user_controller.dart';

class UsersList extends ConsumerStatefulWidget {
  const UsersList({super.key});

  @override
  ConsumerState<UsersList> createState() => _UsersListState();
}

class _UsersListState extends ConsumerState<UsersList> {
  final List<int> _perPages = [5, 10, 20, 50, 100];
  int? _currentPerPage = 5;
  int _currentPage = 1;
  List<Map<String, dynamic>> _source = [];
  bool _isLoading = true;
  _resetData({start: 0, List<Map<String, dynamic>>? data}) async {
    setState(() => _isLoading = true);
    var expandedLen = data!.length - start < _currentPerPage!
        ? data.length - start
        : _currentPerPage;
    _source.clear();
    _source = data.getRange(start, start + expandedLen).toList();
    setState(() => _isLoading = false);
  }

  _mockPullData() {
    var dataLength = ref.watch(filteredUsersToMapProvider).length;
    setState(() => _isLoading = true);
    _source = dataLength >= _currentPerPage!
        ? ref
            .watch(filteredUsersToMapProvider)
            .getRange(0, _currentPerPage!)
            .toList()
        : ref.watch(filteredUsersToMapProvider).toList();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    //check if widget is build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mockPullData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = ref.watch(currentUserController);
    var isSearching = ref.watch(isSearchingProvider);
    var size = MediaQuery.of(context).size;
    int total = ref.watch(filteredUsersToMapProvider).length;

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
              autoHeight: false,
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
                    width: size.width > 900 ? 700 : 430,
                    child: CustomTextFields(
                      hintText: "Search user",
                      onChanged: (value) {
                        ref.read(queryStringProvider.notifier).state = value;
                        _resetData(data: ref.watch(filteredUsersToMapProvider));
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
              source: _source,
              isLoading: _isLoading,
              selecteds: [],
              expanded: [false],
              footers: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Text("Rows per page:"),
                ),
                if (_perPages.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButton<int>(
                      value: _currentPerPage,
                      items: _perPages
                          .map((e) => DropdownMenuItem<int>(
                                value: e,
                                child: Text("$e"),
                              ))
                          .toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          _currentPerPage = value;
                          _currentPage = 1;
                          _resetData(
                              data: ref.watch(filteredUsersToMapProvider));
                        });
                      },
                      isExpanded: false,
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      "$_currentPage - ${_currentPerPage! + _currentPage - 1} of $total"),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
                  onPressed: _currentPage == 1
                      ? null
                      : () {
                          var _nextSet = _currentPage - _currentPerPage!;
                          setState(() {
                            _currentPage = _nextSet > 1 ? _nextSet : 1;
                            _resetData(
                                start: _currentPage - 1,
                                data: ref.watch(filteredUsersToMapProvider));
                          });
                        },
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: _currentPage + _currentPerPage! - 1 > total
                      ? null
                      : () {
                          var nextSet = _currentPage + _currentPerPage!;

                          setState(() {
                            _currentPage = nextSet < total
                                ? nextSet
                                : total - _currentPerPage!;
                            _resetData(
                                start: nextSet - 1,
                                data: ref.watch(filteredUsersToMapProvider));
                          });
                        },
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                )
              ],
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
                    text: "Phone",
                    value: "phone",
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
                    text: "Status",
                    value: "state",
                    show: true,
                    sortable: true,
                    textAlign: TextAlign.center,
                    sourceBuilder: (value, row) {
                      return Text(
                        value.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: value == "Active"
                                ? Colors.green
                                : Colors.redAccent),
                      );
                    }),
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
                      var userState = row['state'];
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
                          if (currentUser.role != null &&
                              currentUser.role!.toLowerCase() == "admin" &&
                              currentUser.userId != value)
                            userState == 'Active'
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      CustomDialog.showInfo(
                                          title: 'Disable User',
                                          buttonText: 'Yes | Disable',
                                          message:
                                              'Are you sure you want to disable this user ?',
                                          onPressed: () =>
                                              deactivateUserAndUpdate(
                                                  value, ref));
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      CustomDialog.showInfo(
                                          title: 'Activate User',
                                          buttonText: 'Yes | Activate',
                                          message:
                                              'Are you sure you want to activate this user ?',
                                          onPressed: () =>
                                              activateUserAndUpdate(
                                                  value, ref));
                                    },
                                  ),
                          if (currentUser.role != null &&
                              currentUser.role!.toLowerCase() == "admin" &&
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

  deactivateUserAndUpdate(value, ref) {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Deactivating User... Please wait');
    try {
      //get the user using the id
      var user = ref
          .watch(userController)
          .firstWhere((element) => element.userId == value);
      //update the user state
      user.state = "Inactive";
      //update the user
      ref.read(userController.notifier).updateUser(user);
      CustomDialog.dismiss();
      CustomDialog.showSuccess(
        title: 'Success',
        message: 'User Deactivated successfully',
      );
    } catch (e) {
      CustomDialog.dismiss();
      CustomDialog.showError(
          title: 'Error',
          message: 'An error occurred while Deactivating the user');
    }
  }

  activateUserAndUpdate(value, WidgetRef ref) {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Activating User... Please wait');
    try {
      //get the user using the id
      var user = ref
          .watch(userController)
          .firstWhere((element) => element.userId == value);
      print(user.toMap());
      //update the user state
      user.state = "Active";
      //update the user
      //print(user.toMap());
      ref.read(userController.notifier).updateUser(user);
      ref.invalidate(userController);
      setState(() {});
      CustomDialog.dismiss();
      CustomDialog.showSuccess(
        title: 'Success',
        message: 'User Activated successfully',
      );
    } catch (e) {
      CustomDialog.dismiss();
      CustomDialog.showError(
          title: 'Error',
          message: 'An error occurred while Activating the user');
    }
  }
}
