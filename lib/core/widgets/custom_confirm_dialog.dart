import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
}) {
  bool themeCondition = context.read<ThemeCubit>().isDarkMode;

  return showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          backgroundColor:
              themeCondition
                  ? ColorsManager.primaryDark
                  : ColorsManager.primaryLight,
          title: Text(title, style: TextStyle(color: ColorsManager.whiteColor)),
          content: Text(
            content,
            style: TextStyle(color: ColorsManager.whiteColor),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                cancelText,
                style: TextStyle(color: ColorsManager.whiteColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.errorColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(
                confirmText,
                style: TextStyle(color: ColorsManager.whiteColor),
              ),
            ),
          ],
        ),
  );
}
