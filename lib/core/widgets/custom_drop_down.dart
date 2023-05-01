import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickchange_pos/utils/app_colors.dart';

import '../../services/settings_controller.dart';

class CustomDropDown extends ConsumerWidget {
  const CustomDropDown(
      {Key? key,
      this.value,
      required this.items,
      this.validator,
      this.hintText,
      this.onChanged,
      this.radius,
      this.onSaved,
      this.label,
      this.iconData})
      : super(key: key);

  final dynamic value;
  final List<DropdownMenuItem> items;
  final String? Function(dynamic)? validator;
  final String? hintText;
  final String? label;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? onSaved;
  final double? radius;
  final IconData? iconData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeMode = ref.watch(themeProvider);
    return DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
      borderRadius: BorderRadius.circular(5),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: const BorderSide(
            color: primaryColors,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: const BorderSide(
            color: primaryColors,
            width: 1,
          ),
        ),
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: const BorderSide(color: primaryColors),
        ),
        prefixIconColor: primaryColors,
        suffixIconColor: primaryColors,
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        labelStyle: normalStyle(
            context: context, fontSize: 14, fontWeight: FontWeight.w300),
        labelText: label,
        hintText: hintText,
        focusColor: secondaryColors,
        iconColor: Colors.grey,
        hintStyle: normalStyle(
            context: context, fontSize: 14, fontWeight: FontWeight.w300),
      ),
      onChanged: onChanged,
      onSaved: onSaved,
      dropdownColor: themeMode.isDark ? secondaryColors : Colors.white,
      items: items,
      validator: validator,
      value: value,
      isExpanded: true,
      icon: Icon(
        iconData ?? Icons.arrow_drop_down,
        color: primaryColors,
      ),
    ));
  }
}
