import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian/utils/theme/app_colors.dart';

final theme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.blueDark,
  scaffoldBackgroundColor: AppColors.white,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.blueDark,
    onPrimary: AppColors.blue,
    secondary: AppColors.grey100,
    onSecondary: AppColors.grey200,
    tertiary: AppColors.grey500,
    onTertiary: AppColors.greyLight,
    error: AppColors.red,
    onError: AppColors.red,
    surface: AppColors.black,
    onSurface: AppColors.grey,
    outline: AppColors.outline,
  ),
  textTheme: TextTheme(
    labelMedium: GoogleFonts.roboto(
      fontSize: 14,
      color: AppColors.outline,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      color: AppColors.blueDark,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 18,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: AppColors.blueDark,
    iconTheme: const IconThemeData(color: AppColors.white),
    titleTextStyle: GoogleFonts.roboto(
      fontSize: 18,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    filled: true,
    fillColor: AppColors.outline,
    hintStyle: GoogleFonts.roboto(
      fontSize: 14,
      color: AppColors.grey,
      fontWeight: FontWeight.w400,
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide.none,
    ),
    prefixIconColor: AppColors.grey500,
  ),
);
