import 'package:flutter/material.dart';
import 'package:quickchange_pos/utils/app_colors.dart';

Widget titleText(BuildContext context, String title,
    {double? fontSize,
    Color? color,
    TextDecoration? textDecoration,
    FontWeight? fontWeight}) {
  return Text(
    title,
    style: titleTextStyle(
        context: context,
        fontSize: fontSize,
        color: color,
        decoration: textDecoration,
        fontWeight: fontWeight),
  );
}
