import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickchange_pos/core/widgets/custom_drop_down.dart';
import 'package:quickchange_pos/models/user_model/user_model.dart';
import 'package:quickchange_pos/pages/init_page/init_page.dart';
import '../../core/constants.dart';
import '../../core/functions/global_functions.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_input.dart';
import '../../core/widgets/smart_dialog.dart';
import '../../generated/assets.dart';
import '../../services/hive_services.dart';
import '../../services/settings_controller.dart';
import '../../services/user_controller.dart';
import '../../utils/app_colors.dart';

class AdministratorInfoPage extends ConsumerStatefulWidget {
  const AdministratorInfoPage({super.key});

  @override
  ConsumerState<AdministratorInfoPage> createState() =>
      _AdministratorInfoPageState();
}

class _AdministratorInfoPageState extends ConsumerState<AdministratorInfoPage> {
  final _sectionOneFormKey = GlobalKey<FormState>();
  final _sectionTwoFormKey = GlobalKey<FormState>();
  //define admin attributes
  Uint8List? profileImage;
  String? adminName;
  String? adminId;
  String? adminPhone;
  String? adminPassword;
  String? secretQuestion1;
  String? secretQuestion2;
  String? answer1;
  String? answer2;
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _answer1Controller = TextEditingController();
  final _answer2Controller = TextEditingController();

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
                                          ' if you are a new user creating an account for your company on Quick Change POS, here are some important things to keep in mind:',
                                      style: normalStyle(
                                          context: context,
                                          color: Colors.white38))
                                ]),
                          ),
                        ),
                        subtitle: SingleChildScrollView(
                          child: Column(
                            children: newUserInfo.map((txt) {
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('NEW ADMINISTRATOR SETUP',
                              style: titleTextStyle(
                                  context: context,
                                  fontSize: size.width * .024,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColors)),
                        ],
                      ),
                      const Divider(
                        thickness: 5,
                        color: primaryColors,
                        height: 5,
                        indent: 30,
                        endIndent: 30,
                      ),
                      const SizedBox(height: 24),
                      IndexedStack(
                        index: index,
                        children: [
                          _sectionOne(),
                          _sectionTwo(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionOne() {
    var themeMode = ref.watch(themeProvider);
    return Form(
      key: _sectionOneFormKey,
      child: Column(
        children: [
          InkWell(
            onTap: () => pickImage(),
            child: profileImage != null
                ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: MemoryImage(profileImage!))),
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      color: primaryColors,
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Select Admin Image',
                        style: normalStyle(context: context),
                      ),
                    ),
                  )
                : Container(
                    width: 200,
                    height: 200,
                    color: themeMode.isDark ? backgroundColors : Colors.black12,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Select Admin Image',
                      style: normalStyle(context: context),
                    ),
                  ),
          ),
          const SizedBox(height: 24),
          CustomTextFields(
            label: 'Enter Admin Name*',
            controller: _nameController,
            onSaved: (name) {
              setState(() {
                adminName = name;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter admin name';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomTextFields(
                  label: 'Enter Admin ID',
                  isCapitalized: true,
                  controller: _idController,
                  onSaved: (id) {
                    setState(() {
                      adminId = id;
                    });
                  },
                  validator: (value) {
                    if (value!.length < 7) {
                      return 'Admin ID can not be less than 5 characters';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: CustomButton(
                  text: 'Auto Generate',
                  color: primaryColors,
                  onPressed: () {
                    setState(() {
                      _idController.text = generateID(ref);
                    });
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          //get user phone number
          CustomTextFields(
            label: 'Enter Admin Phone Number*',
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            isDigitOnly: true,
            onSaved: (phone) {
              setState(() {
                adminPhone = phone;
              });
            },
            validator: (value) {
              if (value!.length != 10) {
                return 'Please enter a valid phone number (10 digits)';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          CustomTextFields(
            label: 'Enter Admin Password*',
            keyboardType: TextInputType.text,
            obscureText: isPasswordVisible,
            controller: _passwordController,
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
                adminPassword = password;
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
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomButton(
                  text: 'Back',
                  color: Colors.red,
                  onPressed: () => gotoPrevious(),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'Continue',
                  onPressed: () => gotoNext(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _sectionTwo() {
    var themeMode = ref.watch(themeProvider);
    return Form(
      key: _sectionTwoFormKey,
      child: Column(
        children: [
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
                        'Answers to the following questions will be used to reset your password if you forget it. Please keep the answers to yourself.',
                    style: normalStyle(context: context, color: Colors.white38))
              ]),
            ),
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
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomButton(
                  text: 'Back',
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      index = 0;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 2,
                  child:
                      CustomButton(text: 'Submit', onPressed: () => submit())),
            ],
          ),
        ],
      ),
    );
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //get image path
    if (image != null) {
      var imageFile = await readFileByte(image.path);
      setState(() {
        profileImage = imageFile;
      });
    }
  }

  gotoNext() async {
    if (_sectionOneFormKey.currentState!.validate()) {
      CustomDialog.showLoading(message: 'Please wait..........');
      try {
        _sectionOneFormKey.currentState!.save();
        CustomDialog.dismiss();
        setState(() {
          index = 1;
        });
      } catch (error) {
        CustomDialog.dismiss();
        CustomDialog.showError(
            title: 'Image Error',
            message: 'There is something wrong with Admin Profile Image');
      }
    }
  }

  gotoPrevious() {
    ref.read(settingsPageIndex.notifier).state = 0;
  }

  submit() async {
    if (_sectionTwoFormKey.currentState!.validate()) {
      CustomDialog.showLoading(message: 'Saving Setup..Please wait.....');
      try {
        _sectionTwoFormKey.currentState!.save();
        // create a new user
        //read the settings from the state and get company name and address
        String companyName = ref.read(settingsController).companyName!;
        UserModel user = UserModel(
            userId: adminId,
            username: adminName,
            password: adminPassword,
            phone: adminPhone,
            profile: profileImage,
            secretQuestion1: secretQuestion1,
            secretQuestion2: secretQuestion2,
            secretAnswer1: answer1,
            secretAnswer2: answer2,
            role: 'Admin',
            company: companyName,
            state: 'Active',
            createdAt: DateTime.now().millisecondsSinceEpoch);
        // Now we get the settings and the user and save them to the database
        ref.read(settingsController.notifier).saveSettings();
        ref.read(userController.notifier).saveUser(user);
        ref.watch(settingsExist.notifier).state = HiveServices.settingsExist();
        CustomDialog.dismiss();
        //show success message and navigate to login page
        CustomDialog.showSuccess(
            title: 'Setup Complete',
            message: 'Setup is complete, Please login to continue');
        //navigate to the init page without returning back
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const InitialPage()));
      } catch (error) {
        CustomDialog.dismiss();
        CustomDialog.showError(
            title: 'Data Saving Error',
            message: 'Something went Wrong, Please try again later');
      }
    }
  }
}
