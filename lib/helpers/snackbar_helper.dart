import 'package:flutter/material.dart';
import 'package:order_manager/settings/app_colors.dart';
import 'package:order_manager/settings/app_fonts.dart';

enum SnackBarType { success, alert, error }

class SnackBarHelper{

  static Future show({
    required BuildContext context,
    required SnackBarType snackBarType,
    required String message,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: snackBarType == SnackBarType.success
        ? AppColors.semanticGreenColor
        : snackBarType == SnackBarType.alert
        ? AppColors.semanticYellowColor
        : AppColors.semanticRedColor,
      content: Text(message, style: AppFonts.bodyBoldDefault.copyWith(
        color: AppColors.whiteColor
      ),),
      duration: const Duration(seconds: 2),
    ));
  }
}