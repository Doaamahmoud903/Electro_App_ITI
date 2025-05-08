import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool themeCondition = context.read<ThemeCubit>().isLightMode;
    String currentLang = Localizations.localeOf(context).languageCode;

    return SizedBox(
      height: currentLang == 'en' ? height * 0.07 : height * 0.09,
      child:
          themeCondition
              ? (currentLang == 'en'
                  ? Image.asset(ImagesAssets.appLogo)
                  : Image.asset(ImagesAssets.logoArDark))
              : (currentLang == 'ar'
                  ? Image.asset(ImagesAssets.logoArLight)
                  : Image.asset(ImagesAssets.mainLogoLight)),
    );
  }
}
