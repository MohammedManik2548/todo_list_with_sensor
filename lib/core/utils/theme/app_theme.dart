
import 'package:flutter/material.dart';
import 'package:todo_list/core/utils/theme/widgets/app_divider_theme.dart';
import 'package:todo_list/core/utils/theme/widgets/app_elevated_button_theme.dart';
import 'package:todo_list/core/utils/theme/widgets/app_outline_button_theme.dart';
import 'package:todo_list/core/utils/theme/widgets/app_text_form_field_theme.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    // dividerTheme: AppDividerTheme.lightDividerTheme,
    // elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    // outlinedButtonTheme: AppOutlineButtonTheme.lightOutlinedButtonTheme,
    // inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.black,
    // dividerTheme: AppDividerTheme.darkDividerTheme,
    // elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    // outlinedButtonTheme: AppOutlineButtonTheme.darkOutlinedButtonTheme,
    // inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
  );
}
