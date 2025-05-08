import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/features/layout/presentation/views/widgets/selected_bottom_item.dart';
import 'package:electro/features/layout/presentation/views/widgets/unselected_bottom_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final themeCubit = context.read<ThemeCubit>();

    return Container(
      height: height * 0.3,
      decoration: BoxDecoration(
        color:
            themeCubit.isDarkMode
                ? ColorsManager.textColor
                : ColorsManager.whiteColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              themeCubit.setLightTheme();
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.02,
              ),
              child:
                  themeCubit.isDarkMode
                      ? UnselectedBottomItem(
                        selectedItem: StringManager.light.tr(context),
                      )
                      : SelectedBottomItem(
                        selectedItem: StringManager.light.tr(context),
                      ),
            ),
          ),
          InkWell(
            onTap: () {
              themeCubit.setDarkTheme();
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.01,
              ),
              child:
                  themeCubit.isDarkMode
                      ? SelectedBottomItem(
                        selectedItem: StringManager.dark.tr(context),
                      )
                      : UnselectedBottomItem(
                        selectedItem: StringManager.dark.tr(context),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
