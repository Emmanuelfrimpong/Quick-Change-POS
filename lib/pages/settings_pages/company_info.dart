import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_input.dart';
import '../../core/widgets/smart_dialog.dart';
import '../../utils/app_colors.dart';

import '../../core/constants.dart';
import '../../core/functions/global_functions.dart';
import '../../generated/assets.dart';
import '../../services/settings_controller.dart';

class CompanyInfoPage extends ConsumerStatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  ConsumerState<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends ConsumerState<CompanyInfoPage> {
  final _formKey = GlobalKey<FormState>();
  //define company attributes
  Uint8List? logo;
  String? companyName;
  String? companyDescription;
  String? companyPhone;
  String? companyLocation;
  String? companyEmail;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //check if widget is done building
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var settings = ref.watch(settingsController);
      if (!settings.isDefault) {
        _nameController.text = settings.companyName ?? settings.companyName!;
        _descriptionController.text =
            settings.companyDescription ?? settings.companyDescription!;
        _phoneController.text = settings.telephone ?? settings.telephone!;
        _locationController.text = settings.location ?? settings.location!;
        _emailController.text = settings.email ?? settings.email!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeMode = ref.watch(themeProvider);
    var theme = AdaptiveTheme.of(context).theme;
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
              child: Form(
                key: _formKey,
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
                            Text('NEW COMPANY SETUP',
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
                          indent: 30,
                          endIndent: 30,
                        ),
                        const SizedBox(height: 24),
                        InkWell(
                          onTap: () => pickImage(),
                          child: logo != null
                              ? Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(logo!))),
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                    color: primaryColors,
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'Select Company Logo*',
                                      style: normalStyle(context: context),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 200,
                                  height: 200,
                                  color: themeMode.isDark
                                      ? backgroundColors
                                      : Colors.black12,
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    'Select Company Logo*',
                                    style: normalStyle(context: context),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 24),
                        CustomTextFields(
                          label: 'Enter Company Name*',
                          controller: _nameController,
                          onSaved: (name) {
                            setState(() {
                              companyName = name;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter company name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTextFields(
                          label: 'Enter Company Description*',
                          controller: _descriptionController,
                          maxLines: 4,
                          onSaved: (description) {
                            setState(() {
                              companyDescription = description;
                            });
                          },
                          validator: (value) {
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTextFields(
                          label: 'Enter Company Telephone*',
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          max: 10,
                          onSaved: (phone) {
                            setState(() {
                              companyPhone = phone;
                            });
                          },
                          validator: (value) {
                            if (value!.length != 10) {
                              return 'Please enter valid phone number (10 digits)';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTextFields(
                          label: 'Enter Company Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (email) {
                            setState(() {
                              companyEmail = email;
                            });
                          },
                          validator: (value) {
                            if (value!.isNotEmpty &&
                                !emailRegEx.hasMatch(value)) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTextFields(
                          label: 'Enter Company Location*',
                          controller: _locationController,
                          onSaved: (location) {
                            setState(() {
                              companyLocation = location;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter company Location';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: 'Continue',
                          onPressed: () => gotoNext(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
        logo = imageFile;
      });
    }
  }

  gotoNext() async {
    if (_formKey.currentState!.validate()) {
      if (logo != null) {
        CustomDialog.showLoading(message: 'Please wait..........');
        try {
          _formKey.currentState!.save();
          ref.read(settingsController.notifier).updateFields(
              companyDescription: companyDescription,
              companyEmail: companyEmail,
              companyLocation: companyLocation,
              companyName: companyName,
              companyPhone: companyPhone,
              logo: logo);
          CustomDialog.dismiss();
          ref.read(settingsPageIndex.notifier).state = 1;
        } catch (error) {
          CustomDialog.dismiss();
          CustomDialog.showError(
              title: 'Image Error',
              message: 'There is something wrong with company logo');
        }
      } else {
        CustomDialog.showError(
            title: 'Missing data', message: 'Company Logo is required');
      }
    }
  }
}
