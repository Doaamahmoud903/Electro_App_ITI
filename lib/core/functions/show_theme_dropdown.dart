import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/features/layout/presentation/views/widgets/theme_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showThemeDropdownList(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: BlocProvider.of<ThemeCubit>(context),
        child: const ThemeBottomSheet(),
      );
    },
    backgroundColor:
        context.read<ThemeCubit>().isDarkMode
            ? ColorsManager.textColor
            : ColorsManager.whiteColor,
  );
}
