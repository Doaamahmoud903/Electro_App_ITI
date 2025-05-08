import 'package:electro/core/theming/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:go_router/go_router.dart';

Future<void> showThemeDialog(BuildContext context) async {
  final isLight = context.read<ThemeCubit>().isLightMode;

  await showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor:
              isLight ? ColorsManager.whiteColor : ColorsManager.primaryDark,
          title: Text(StringManager.theme.tr(context)),
          actions: [
            TextButton(
              onPressed: () {
                if (!isLight) {
                  context.read<ThemeCubit>().setLightTheme();
                }
                GoRouter.of(context).pop();
              },
              child: Text(
                StringManager.light.tr(context),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (isLight) {
                  context.read<ThemeCubit>().setDarkTheme();
                }
                GoRouter.of(context).pop();
              },
              child: Text(
                StringManager.dark.tr(context),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
  );
}
