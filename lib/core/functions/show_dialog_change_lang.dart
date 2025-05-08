import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/localization/locale_cubit/locale_cubit.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/features/account/presentation/manager/pic_lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';

Future<dynamic> showDialogChangeLang(BuildContext context) {
  String currentLang = Localizations.localeOf(context).languageCode;
  var cubit = PicLangCubit.get(context);
  final isLight = context.read<ThemeCubit>().isLightMode;

  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor:
              isLight ? ColorsManager.whiteColor : ColorsManager.primaryDark,
          title: Text(StringManager.changeLanguage.tr(context)),
          actions: [
            TextButton(
              onPressed: () {
                if (currentLang != 'ar') {
                  BlocProvider.of<LocaleCubit>(context).changeLanguage("ar");
                  //.then((value) {
                  //   Restart.restartApp();
                  // });
                  cubit.changePicLang("ar");
                }
                GoRouter.of(context).pop();
              },
              child: Text(
                StringManager.arabic.tr(context),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
                if (currentLang != 'en') {
                  cubit.changePicLang("en");
                  BlocProvider.of<LocaleCubit>(
                    context,
                  ).changeLanguage("en").then((value) {
                    //Restart.restartApp();
                  });
                }
              },
              child: Text(
                StringManager.english.tr(context),
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
