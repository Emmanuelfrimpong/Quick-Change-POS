// now let create a user provider to save a new user and return a new user
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickchange_pos/models/user_model/user_model.dart';
import 'package:quickchange_pos/services/hive_services.dart';

final userController =
    StateNotifierProvider<UserController, List<UserModel>>((ref) {
  return UserController();
});

class UserController extends StateNotifier<List<UserModel>> {
//get user from hive by default
  UserController() : super(HiveServices.getUsers());
  void getUsers() {
    state = HiveServices.getUsers();
  }

  void saveUser(UserModel userModel) {
    //save user to hive
    HiveServices.setUser(userModel);
    getUsers();
  }

  //update user in the database
  void updateUser(UserModel userModel) {
    HiveServices.setUser(userModel);
    getUsers();
  }

  //delete user from the database
  void deleteUser(UserModel userModel) {
    HiveServices.deleteUser(userModel);
    getUsers();
  }

  //user login with id and password
  UserModel userLogin(String userId, String password) {
    return state.firstWhere(
        (element) =>
            element.userId!.toLowerCase() == userId.toLowerCase() &&
            element.password == password,
        orElse: () => UserModel.defaultUser());
  }

//check if user secret questions matches the one in the database
  UserModel resetPassword(
      {required String id,
      required String question1,
      required String question2,
      required String answer1,
      required String answer2}) {
    return state.firstWhere(
      (element) {
        return element.userId!.toLowerCase() == id.toLowerCase() &&
            element.secretQuestion1 == question1 &&
            element.secretQuestion2 == question2 &&
            element.secretAnswer1!.toLowerCase() == answer1.toLowerCase() &&
            element.secretAnswer2!.toLowerCase() == answer2.toLowerCase();
      },
      orElse: () => UserModel.defaultUser(),
    );
  }

//change user password
  void savePassword(UserModel user) {
    HiveServices.setUser(user);
    getUsers();
  }

  UserModel updateLastLogin(UserModel user) {
    user.lastLogin = DateTime.now().millisecondsSinceEpoch;
    HiveServices.setUser(user);
    getUsers();
    return user;
  }

  UserModel getUser(String userId) {
    return state.firstWhere(
      (element) => element.userId!.toLowerCase() == userId.toLowerCase(),
      orElse: () => UserModel.defaultUser(),
    );
  }
}

final currentUserController = Provider<UserModel>((ref) {
  var id = HiveServices.getCurrentUser();
  var user = ref.read(userController.notifier).getUser(id);
  return user;
});