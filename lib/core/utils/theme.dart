import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_fonts.dart';
import 'package:se7ety/core/utils/colors.dart';

class AppTheme {
  static get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.wightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.darkColor,
    ),
    fontFamily: AppFonts.cairo,
    dividerColor: AppColors.greyColor,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.greyColor.withValues(alpha: 2.0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static get darkTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.darkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.wightColor,
    ),
    fontFamily: AppFonts.cairo,
    dividerColor: AppColors.greyColor,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
