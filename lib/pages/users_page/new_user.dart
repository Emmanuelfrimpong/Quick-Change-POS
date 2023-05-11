import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickchange_pos/core/widgets/custom_drop_down.dart';
import 'package:quickchange_pos/core/widgets/custom_input.dart';
import 'package:quickchange_pos/core/widgets/smart_dialog.dart';
import 'package:quickchange_pos/models/user_model/user_model.dart';
import 'package:quickchange_pos/utils/app_colors.dart';

import '../../core/functions/global_functions.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/title_text.dart';
import '../../services/page_navigation_controller.dart';
import '../../services/settings_controller.dart';
import '../../services/user_controller.dart';

class NewUsers extends ConsumerStatefulWidget {
  const NewUsers({super.key});

  @override
  ConsumerState<NewUsers> createState() => _NewUsersState();
}

class _NewUsersState extends ConsumerState<NewUsers> {
  //create a form key
  final _formKey = GlobalKey<FormState>();
  Uint8List? profileImage;
  String? userName, userPhone, userRole, userId;
  final _userIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //create a new user page which will have a form which contains the following:
    // 1. name
    // 2. user telephone number
    // 3. the user role (Admin or Sales person)
    // 4. the user password (123456 by default)
    // 5. the user id (Auto generated)
    // 6. the user picture (optional)
    var size = MediaQuery.of(context).size;
    var themeMode = ref.read(themeProvider);
    //create a card to hold the form with border radius of 20
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
          child: ListTile(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    //create a back button
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: CustomButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        onPressed: () => {
                          //go to new user page
                          ref.read(userPageIndexProvider.notifier).state = 0
                        },
                        icon: Icons.arrow_back,
                        text: "Back",
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    titleText(context, 'New User', fontSize: 40),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  height: 20,
                )
              ],
            ),
            subtitle: Column(children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width >= 1000 ? size.width * 0.14 : 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPictureSection(),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(child: _buildForm()),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ));
  }

  Widget _buildForm() {
    var width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: width >= 1000 ? width * 0.35 : width * 0.8,
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFields(
                    controller: _userIdController,
                    label: 'Enter User ID',
                    isCapitalized: true,
                    onSaved: (id) {
                      setState(() {
                        userId = id;
                      });
                    },
                    validator: (value) {
                      if (value!.length < 7) {
                        return 'User ID can not be less than 5 characters';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: CustomButton(
                    text: 'Auto Generate',
                    color: primaryColors,
                    onPressed: () {
                      setState(() {
                        _userIdController.text = generateID(ref);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: width >= 1000 ? width * 0.35 : width * 0.8,
            child: CustomTextFields(
              label: 'Enter User name',
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please enter a valid name';
                }
                return null;
              },
              onSaved: (name) {
                setState(() {
                  userName = name;
                });
              },
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: width >= 1000 ? width * 0.35 : width * 0.8,
            child: CustomTextFields(
              label: 'Enter User Phone Number*',
              keyboardType: TextInputType.phone,
              isDigitOnly: true,
              onSaved: (phone) {
                setState(() {
                  userPhone = phone;
                });
              },
              validator: (value) {
                if (value!.length != 10) {
                  return 'Please enter a valid phone number (10 digits)';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: width >= 1000 ? width * 0.35 : width * 0.8,
            child: CustomDropDown(
                label: 'Select User Role',
                value: userRole,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a user role';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    userRole = value;
                  });
                },
                onChanged: (value) {},
                items: ['Admin', 'Sales', 'Manager'].map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: normalStyle(context: context),
                    ),
                  );
                }).toList()),
          ),
          const SizedBox(height: 40),
          SizedBox(
              width: width >= 1000 ? width * 0.35 : width * 0.8,
              child: CustomButton(
                  text: 'Create User', onPressed: () => saveNewUser())),
        ],
      ),
    );
  }

  Widget _buildPictureSection() {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          profileImage != null
              ? InkWell(
                  onTap: () => pickImage(),
                  child: Container(
                    width: 180,
                    height: 180,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(profileImage!),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 6,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Container(
                        color: primaryColors,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Change image',
                          style: normalStyle(context: context),
                        )),
                  ),
                )
              : InkWell(
                  onTap: () => pickImage(),
                  child: Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 6,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Container(
                        color: primaryColors,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Select image',
                          style: normalStyle(context: context),
                        )),
                  ),
                ),
          //give user instructions on how to select image
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black54.withOpacity(.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: RichText(
                text: TextSpan(
                    text: 'Note: \n',
                    style: normalStyle(context: context, color: Colors.red),
                    children: [
                  TextSpan(
                      text: 'User Password by default is ',
                      style:
                          normalStyle(context: context, color: Colors.white)),
                  TextSpan(
                      text: '123456.\n',
                      style: normalStyle(
                          context: context,
                          color: primaryColors,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'User will be required to change password on first login.',
                      style:
                          normalStyle(context: context, color: Colors.white)),
                ])),
          ),
          const SizedBox(
            height: 50,
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

  void saveNewUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //check if user id already exist
      if (checkIfUserExist(ref, userId!)) {
        CustomDialog.showError(
            title: 'Error',
            message:
                'User ID already exist. Click on Generate ID to generate a new ID');
      } else {
        CustomDialog.showLoading(message: 'Saving new user..Please wait.....');
        try {
          String companyName = ref.read(settingsController).companyName!;
          UserModel userModel = UserModel()
            ..password = '123456'
            ..company = companyName
            ..phone = userPhone!
            ..role = userRole!
            ..username = userName!
            ..userId = userId!
            ..profile = profileImage
            ..state = 'Inactive'
            ..createdAt = DateTime.now().toUtc().millisecondsSinceEpoch;
          ref.read(userController.notifier).saveUser(userModel);
          //clear form
          _formKey.currentState!.reset();
          _userIdController.clear();
          profileImage = null;
          userRole = null;
          //show success message
          CustomDialog.dismiss();
          //show success message and navigate to login page
          CustomDialog.showSuccess(
              title: 'Success',
              message: 'User created successfully. User ID is $userId and '
                  'password is 123456. User will be required to change password on first login');
        } catch (e) {
          CustomDialog.dismiss();
          CustomDialog.showError(
              title: 'Data Saving Error',
              message: 'Something went Wrong, Please try again later');
        }
      }
    }
  }
}
