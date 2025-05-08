// theme.dart
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/styles_manager.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData.light().copyWith(
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    textTheme: TextTheme(
      bodyMedium: Styles.textStyle16w5.copyWith(color: Colors.black),
      headlineLarge: Styles.textStyle20w7.copyWith(color: Colors.black),
      headlineMedium: Styles.textStyle18w5.copyWith(color: Colors.black),
      headlineSmall: Styles.textStyle14w5.copyWith(color: Colors.black),
      bodyLarge: Styles.textStyle24w7.copyWith(color: ColorsManager.primary),
      displayMedium: Styles.textStyle16w5.copyWith(
        color: ColorsManager.primary,
      ),
      displayLarge: Styles.textStyle22w7.copyWith(color: Colors.black),
      titleLarge: Styles.textStyle22w7.copyWith(color: ColorsManager.primary),
    ),
    scaffoldBackgroundColor: ColorsManager.whiteColor,
    primaryColor: ColorsManager.primaryDark,
    focusColor: ColorsManager.textColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.primary,
      selectedItemColor: ColorsManager.textColor,
      unselectedItemColor: ColorsManager.whiteColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.whiteColor,
      iconTheme: IconThemeData(color: ColorsManager.primaryLight, size: 22),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    textTheme: TextTheme(
      bodyMedium: Styles.textStyle16w5.copyWith(color: Colors.white),
      headlineLarge: Styles.textStyle20w7.copyWith(color: Colors.white),
      headlineMedium: Styles.textStyle18w5.copyWith(color: Colors.white),
      headlineSmall: Styles.textStyle14w5.copyWith(color: Colors.white),
      bodyLarge: Styles.textStyle24w7.copyWith(color: ColorsManager.primary),
      displayMedium: Styles.textStyle16w5.copyWith(
        color: ColorsManager.whiteColor,
      ),
      displayLarge: Styles.textStyle22w7.copyWith(color: Colors.white),
      titleLarge: Styles.textStyle22w7.copyWith(color: ColorsManager.primary),
    ),
    scaffoldBackgroundColor: ColorsManager.textColor,
    primaryColor: ColorsManager.primary,
    focusColor: ColorsManager.whiteColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.textColor,
      selectedItemColor: ColorsManager.primaryLight,
      unselectedItemColor: Colors.grey.shade500,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.primaryDark,
      iconTheme: const IconThemeData(color: Colors.white, size: 22),
    ),
  );
}
