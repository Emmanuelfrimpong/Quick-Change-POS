import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickchange_pos/core/widgets/custom_button.dart';
import 'package:quickchange_pos/core/widgets/custom_input.dart';
import 'package:quickchange_pos/utils/app_colors.dart';

import '../../core/constants.dart';
import '../../services/settings_controller.dart';

class CompanyInfoPage extends ConsumerStatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  ConsumerState<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends ConsumerState<CompanyInfoPage> {
  final _formKey = GlobalKey<FormState>();
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
              child: Column(children: [
                //add logo here
              
              ]),
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
                          child: Container(
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
                          onSaved: (name) {
                            ref
                                .read(settingsController.notifier)
                                .state!
                                .companyName = name!;
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
                          maxLines: 4,
                          onSaved: (description) {
                            ref
                                .read(settingsController.notifier)
                                .state!
                                .companyDescription = description!;
                          },
                          validator: (value) {
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTextFields(
                          label: 'Enter Company Telephone*',
                          keyboardType: TextInputType.phone,
                          max: 10,
                          onSaved: (phone) {
                            ref
                                .read(settingsController.notifier)
                                .state!
                                .telephone = phone!;
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
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (email) {
                            ref.read(settingsController.notifier).state!.email =
                                email!;
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
                          onSaved: (location) {
                            ref
                                .read(settingsController.notifier)
                                .state!
                                .location = location!;
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
  }

  gotoNext() {}
}
