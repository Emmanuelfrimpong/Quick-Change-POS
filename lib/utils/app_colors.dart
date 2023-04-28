import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColors = Color(0xFFEFAB40);
const secondaryColors = Color.fromARGB(221, 1, 3, 32);
const backgroundColors = Color.fromARGB(255, 1, 2, 15);

// Define the dark theme
final ThemeData kDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: secondaryColors,
    scaffoldBackgroundColor: backgroundColors,
    appBarTheme: const AppBarTheme(backgroundColor: backgroundColors),
    cardColor: const Color(0xFF3D3D3D),
    textTheme: GoogleFonts.robotoTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.white,
      background: secondaryColors,
    ));
// Define the light theme
final ThemeData kLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  cardColor: Colors.white,
  textTheme: GoogleFonts.robotoTextTheme(),
);

//define textStyles base on active theme
TextStyle titleTextStyle(
        {required BuildContext context,
        FontWeight? fontWeight,
        TextDecoration? decoration,
        double? fontSize,
        Color? color}) =>
    GoogleFonts.roboto(
      fontSize: fontSize ?? 25,
      fontWeight: fontWeight ?? FontWeight.w500,
      decoration: decoration ?? TextDecoration.none,
      color: color ??
          (AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black),
    );

TextStyle subTitleStyle(
        {required BuildContext context,
        FontWeight? fontWeight,
        TextDecoration? decoration,
        double? fontSize,
        Color? color}) =>
    GoogleFonts.roboto(
      fontSize: fontSize ?? 20,
      decoration: decoration ?? TextDecoration.none,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ??
          (AdaptiveTheme.of(context).mode.isDark
              ? Colors.white
              : Colors.black54),
    );

TextStyle normalStyle(
        {required BuildContext context,
        FontWeight? fontWeight,
        TextDecoration? decoration,
        double? fontSize,
        Color? color}) =>
    GoogleFonts.roboto(
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.normal,
      decoration: decoration ?? TextDecoration.none,
      color: color ??
          (AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black),
    );
