import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_colors.dart';

class CustomTextFields extends ConsumerWidget {
  const CustomTextFields({
    Key? key,
    this.controller,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.maxLines,
    this.hintText,
    this.radius,
    this.isCapitalized = false,
    this.isDigitOnly = false,
    this.isReadOnly = false,
    this.onTap,
    this.color = Colors.white,
    this.max = 999999,
    this.min = 0,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final int? maxLines;
  final double? radius;
  final bool? isCapitalized;
  final bool? isDigitOnly;
  final bool? isReadOnly;
  final Color color;
  final int? max, min;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      onTap: onTap,
      validator: validator,
      inputFormatters: [
        if (isCapitalized!) UpperCaseTextFormatter(),
        if (isDigitOnly ?? false)
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        PreventDeleteFormatter(max!, min!),
      ],
      textCapitalization: isCapitalized!
          ? TextCapitalization.characters
          : TextCapitalization.none,
      style: normalStyle(
          context: context, fontSize: 16, fontWeight: FontWeight.bold),
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines ?? 1,
      readOnly: isReadOnly ?? false,
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
        contentPadding: EdgeInsets.symmetric(
            horizontal: 6, vertical: maxLines != null ? 15 : 5),
        labelStyle: normalStyle(
            context: context, fontSize: 14, fontWeight: FontWeight.w300),
        labelText: label,
        hintText: hintText,
        focusColor: primaryColors,
        iconColor: Colors.grey,
        hintStyle: normalStyle(
            context: context, fontSize: 14, fontWeight: FontWeight.w300),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 18,
                color: primaryColors,
              )
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (RegExp("[a-zA-Z0-9,]").hasMatch(newValue.text)) {
      return TextEditingValue(
        text: newValue.text.toUpperCase(),
        selection: newValue.selection,
      );
    }
    return newValue;
  }
}

class PreventDeleteFormatter extends TextInputFormatter {
  final int max, min;

  PreventDeleteFormatter(this.max, this.min);
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > min - 1 && newValue.text.length < max + 1) {
      return newValue;
    }
    return oldValue;
  }
}
