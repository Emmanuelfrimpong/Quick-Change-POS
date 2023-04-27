import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const primaryColors=Color(0xFFEFAB40);
const secondaryColors=Color(0xFF01031C);

// Define the dark theme
final ThemeData kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: secondaryColors,
  scaffoldBackgroundColor: secondaryColors,
  appBarTheme: const AppBarTheme(
    backgroundColor: secondaryColors
  ),
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

  )
);
// Define the light theme
final ThemeData kLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white
  ),
  cardColor: Colors.white,
  textTheme: GoogleFonts.robotoTextTheme(),
);

//define textStyles base on active theme
TextStyle titleTextStyle({required BuildContext context,FontWeight? fontWeight})=>GoogleFonts.roboto(
  fontSize: 25,
  fontWeight:fontWeight?? FontWeight.w500,
  color: AdaptiveTheme.of(context).mode.isDark? Colors.white:Colors.black54,
);

TextStyle subTitleStyle({required BuildContext context,FontWeight? fontWeight})=>GoogleFonts.roboto(
  fontSize: 20,
  fontWeight:fontWeight?? FontWeight.w500,
  color: AdaptiveTheme.of(context).mode.isDark?  Colors.white:Colors.black54,
);

TextStyle normalStyle({required BuildContext context,FontWeight? fontWeight,TextDecoration ?decoration, double? fontSize})=>GoogleFonts.roboto(
  fontSize: fontSize?? 14,
  fontWeight:fontWeight?? FontWeight.normal,
  decoration: decoration??TextDecoration.none,
  color: AdaptiveTheme.of(context).mode.isDark?  Colors.white:Colors.black54,
);