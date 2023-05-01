import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickchange_pos/core/widgets/smart_dialog.dart';
import 'package:quickchange_pos/services/hive_services.dart';
import 'package:quickchange_pos/services/user_controller.dart';
import '../../core/constants.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_drop_down.dart';
import '../../core/widgets/custom_input.dart';
import '../../generated/assets.dart';
import '../../services/settings_controller.dart';
import '../../utils/app_colors.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  String? secretQuestion1;
  String? secretQuestion2;
  String? answer1;
  String? answer2;
  final _answer1Controller = TextEditingController();
  final _answer2Controller = TextEditingController();

  final _idController = TextEditingController();
  String? _newPassword, _confirmPassword;

  final _formKey = GlobalKey<FormState>();
  final _forgetFormKey = GlobalKey<FormState>();
  final _newPasswordFormKey = GlobalKey<FormState>();
  String? _id, _password;
  bool isPasswordVisible = true;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var themeMode = ref.watch(themeProvider);
    var size = MediaQuery.of(context).size;

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
          horizontal: size.width > 900 && size.width <= 1200
              ? size.width * .08
              : size.width > 1200
                  ? size.width * .11
                  : 5,
          vertical: size.height * .08),
      color: themeMode.isDark ? secondaryColors : Colors.white,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: size.height * 0.85,
              decoration: const BoxDecoration(
                color: primaryColors,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //add logo here

                      Image.asset(
                        Assets.imagesLogoPrimary,
                        width: size.width * .23,
                      ),
                      ListTile(
                        title: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black54.withOpacity(.5)),
                          padding: const EdgeInsets.all(15),
                          child: RichText(
                            text: TextSpan(
                                text: 'Note:',
                                style: subTitleStyle(
                                    context: context,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                children: [
                                  TextSpan(
                                      text:
                                          ' If you are a new user, please contact your administrator to create an account for you.',
                                      style: normalStyle(
                                          context: context,
                                          color: Colors.white38))
                                ]),
                          ),
                        ),
                        subtitle: SingleChildScrollView(
                          child: Column(
                            children: loginInfo.map((txt) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 40, right: 5, top: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black54.withOpacity(.5)),
                                padding: const EdgeInsets.all(15),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: txt,
                                        style: normalStyle(
                                            context: context,
                                            color: Colors.white38))
                                  ]),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: themeMode.isDark ? secondaryColors : Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: IndexedStack(
                index: index,
                children: [
                  _loginScreen(),
                  _forgotPassword(),
                  _newPasswordScreen(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _loginScreen() {
    var themeMode = ref.watch(themeProvider);
    var size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('USER LOGIN',
                    style: titleTextStyle(
                        context: context,
                        fontSize: size.width * .027,
                        fontWeight: FontWeight.bold,
                        color: primaryColors)),
              ],
            ),
            const Divider(
              thickness: 5,
              color: primaryColors,
              height: 5,
              indent: 100,
              endIndent: 100,
            ),
            const SizedBox(height: 50),
            CustomTextFields(
              label: 'Enter Your ID*',
              isCapitalized: true,
              onSaved: (id) {
                setState(() {
                  _id = id;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your user ID';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            CustomTextFields(
              label: 'Enter Your Password*',
              keyboardType: TextInputType.text,
              obscureText: isPasswordVisible,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(!isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility)),
              onSaved: (password) {
                setState(() {
                  _password = password;
                });
              },
              validator: (value) {
                if (value!.length < 6) {
                  return 'Password can not be less than 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),

            CustomButton(
              text: 'Login',
              onPressed: () => login(),
            ),
            const SizedBox(height: 30),
            //create forget password button here using RichText
            InkWell(
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
              child: RichText(
                text: TextSpan(
                    text: 'Forgot Password?',
                    style: normalStyle(
                        context: context,
                        color: themeMode.isDark ? Colors.white : Colors.black),
                    children: [
                      TextSpan(
                          text: ' Click Here',
                          style: normalStyle(
                              context: context,
                              color: primaryColors,
                              fontWeight: FontWeight.bold))
                    ]),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    var themeMode = ref.watch(themeProvider);
    var size = MediaQuery.of(context).size;
    return Form(
      key: _forgetFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('PASSWORD RECOVERY',
                      style: titleTextStyle(
                          context: context,
                          fontSize: size.width * .027,
                          fontWeight: FontWeight.bold,
                          color: primaryColors)),
                ],
              ),
              const Divider(
                thickness: 5,
                color: primaryColors,
                height: 5,
                indent: 60,
                endIndent: 60,
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: themeMode.isDark
                        ? Colors.white.withOpacity(.4)
                        : Colors.black.withOpacity(.5)),
                padding: const EdgeInsets.all(15),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text:
                            'Select the secret question and enter the answer you provided during registration to reset your password.',
                        style: normalStyle(
                            context: context, color: Colors.white38))
                  ]),
                ),
              ),
              const SizedBox(height: 24),
              CustomTextFields(
                label: 'Enter Your ID*',
                isCapitalized: true,
                onSaved: (id) {
                  setState(() {
                    _id = id;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your user ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CustomDropDown(
                label: 'Select Secret Question 1*',
                value: secretQuestion1,
                validator: (value) {
                  if (value == null) {
                    return 'Please select secret question';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    secretQuestion1 = value;
                  });
                },
                onChanged: (p0) => setState(() => secretQuestion1 = p0),
                items: secretQuestion.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: normalStyle(
                          context: context,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: CustomTextFields(
                  label: 'Enter Answer 1*',
                  controller: _answer1Controller,
                  onSaved: (value) {
                    setState(() {
                      answer1 = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter answer';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              CustomDropDown(
                label: 'Select Secret Question 2*',
                value: secretQuestion2,
                validator: (value) {
                  if (value == null) {
                    return 'Please select secret question';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    secretQuestion2 = value;
                  });
                },
                onChanged: (p0) => setState(() => secretQuestion2 = p0),
                items: secretQuestion.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: normalStyle(
                          context: context,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: CustomTextFields(
                  label: 'Enter Answer 2*',
                  controller: _answer2Controller,
                  onSaved: (value) {
                    setState(() {
                      answer2 = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter answer';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(text: 'Reset', onPressed: () => resetPassword()),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: RichText(
                  text: TextSpan(
                      text: 'Back to Login',
                      style: normalStyle(
                          context: context,
                          color:
                              themeMode.isDark ? Colors.white : Colors.black),
                      children: [
                        TextSpan(
                            text: ' Click Here',
                            style: normalStyle(
                                context: context,
                                color: primaryColors,
                                fontWeight: FontWeight.bold))
                      ]),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newPasswordScreen() {
    var themeMode = ref.watch(themeProvider);
    var size = MediaQuery.of(context).size;
    return Form(
      key: _newPasswordFormKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('NEW PASSWORD',
                    style: titleTextStyle(
                        context: context,
                        fontSize: size.width * .027,
                        fontWeight: FontWeight.bold,
                        color: primaryColors)),
              ],
            ),
            const Divider(
              thickness: 5,
              color: primaryColors,
              height: 5,
              indent: 100,
              endIndent: 100,
            ),
            const SizedBox(height: 50),
            CustomTextFields(
              label: 'User ID',
              isReadOnly: true,
              isCapitalized: true,
              controller: _idController,
              onSaved: (id) {
                setState(() {
                  _id = id;
                });
              },
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(height: 24),
            CustomTextFields(
              label: 'Enter New Password*',
              keyboardType: TextInputType.text,
              obscureText: isPasswordVisible,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(!isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility)),
              onSaved: (password) {
                setState(() {
                  _newPassword = password;
                });
              },
              validator: (value) {
                if (value!.length < 6) {
                  return 'Password can not be less than 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            CustomTextFields(
              label: 'Confirm New Password*',
              keyboardType: TextInputType.text,
              obscureText: isPasswordVisible,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(!isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility)),
              onSaved: (password) {
                setState(() {
                  _confirmPassword = password;
                });
              },
              validator: (value) {
                if (value!.length < 6) {
                  return 'Password can not be less than 6 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: 'Save Password',
              onPressed: () => savePassword(),
            ),
            const SizedBox(height: 30),
            //back to login
            InkWell(
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
              child: RichText(
                text: TextSpan(
                    text: 'Back to Login',
                    style: normalStyle(
                        context: context,
                        color: themeMode.isDark ? Colors.white : Colors.black),
                    children: [
                      TextSpan(
                          text: ' Click Here',
                          style: normalStyle(
                              context: context,
                              color: primaryColors,
                              fontWeight: FontWeight.bold))
                    ]),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //show loading
      CustomDialog.showLoading(message: 'Logging in Please wait...');
      var user = ref.watch(userController.notifier).userLogin(_id!, _password!);
      if (!user.isDefault) {
        //update user lastLogin
        var newUser = ref.read(userController.notifier).updateLastLogin(user);
        //update current user
        HiveServices.setCurrentUser(newUser.userId!);
        CustomDialog.dismiss();
        CustomDialog.showToast(message: 'Login Successful');
        ref.read(authStatus.notifier).updateAuthStatus(true);
      } else {
        CustomDialog.dismiss();
        CustomDialog.showError(
          title: 'Invalid User',
          message: 'Invalid User ID or Password',
        );
      }
    }
  }

  resetPassword() {
    if (_forgetFormKey.currentState!.validate()) {
      _forgetFormKey.currentState!.save();
      //show loading
      CustomDialog.showLoading(message: 'Resetting Please wait...');
      var user = ref.read(userController.notifier).resetPassword(
          id: _id!,
          answer1: answer1!,
          answer2: answer2!,
          question1: secretQuestion1!,
          question2: secretQuestion2!);
      if (!user.isDefault) {
        //update current user
        HiveServices.setCurrentUser(user.userId!);
        CustomDialog.dismiss();
        setState(() {
          index = 2;
          _idController.text = user.userId!;
        });
      } else {
        CustomDialog.dismiss();
        CustomDialog.showError(
          title: 'Invalid User',
          message: 'Invalid User ID or Answer',
        );
      }
    }
  }

  savePassword() {
    if (_newPasswordFormKey.currentState!.validate()) {
      _newPasswordFormKey.currentState!.save();
      //check if password match
      if (_newPassword != _confirmPassword) {
        CustomDialog.showError(
          title: 'Password Mismatch',
          message: 'Password does not match',
        );
        return;
      }
      //show loading
      CustomDialog.showLoading(message: 'Saving Password..Please wait...');
      var user = ref.watch(currentUserController);
      user.password = _newPassword!;
      ref.read(userController.notifier).savePassword(user);
      CustomDialog.dismiss();
      CustomDialog.showSuccess(
          title: 'Change of Password',
          message: 'Password Changed Successfully');
      setState(() {
        index = 0;
      });
    }
  }
}
