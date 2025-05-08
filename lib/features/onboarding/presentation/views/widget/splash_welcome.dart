import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/localization/locale_cubit/locale_cubit.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as PicLangCubit;
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  final VoidCallback onStart;
  const WelcomeScreen({super.key, required this.onStart});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String currentLang = Localizations.localeOf(context).languageCode;
    var themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              ImagesAssets.mainSplashIcon,
              height: height * 0.5,
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Text(
              StringManager.splashP1Title.tr(context),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Text(
              StringManager.splashP1Body.tr(context),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringManager.language.tr(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                GestureDetector(
                  onTap: () {
                    if (currentLang == "en") {
                      BlocProvider.of<LocaleCubit>(
                        context,
                      ).changeLanguage("ar");
                    } else {
                      BlocProvider.of<LocaleCubit>(
                        context,
                      ).changeLanguage("en");
                    }
                  },
                  child: Image.asset(ImagesAssets.langSwitch, width: 74),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringManager.theme.tr(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                InkWell(
                  onTap: () {
                    themeCubit.toggleTheme();
                  },
                  child: Image.asset(
                    ImagesAssets.themeSwitch,
                    width: 74,
                    height: 31,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.onStart();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  StringManager.splashBtn.tr(context),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void showLanguageDropdownList() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => LanguageBottomSheet(),
  //   );
  // }

  // void showThemeDropdownList(themeProvider) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => ThemeBottomSheet(),
  //     backgroundColor:
  //         themeProvider.currentTheme == ThemeMode.light
  //             ? AppColors.whiteColor
  //             : AppColors.darkBlueColor,
  //   );
  // }
}
