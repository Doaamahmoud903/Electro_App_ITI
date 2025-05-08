import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroAppLogo extends StatelessWidget {
  const IntroAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool themeCondition = context.read<ThemeCubit>().isLightMode;
    String currentLang = Localizations.localeOf(context).languageCode;

    return SizedBox(
      width: width * 0.6,
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
