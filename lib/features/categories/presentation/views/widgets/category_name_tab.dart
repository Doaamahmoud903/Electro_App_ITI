import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/styles_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryNameTab extends StatelessWidget {
  final String name;
  final bool isSelected;
  const CategoryNameTab({
    super.key,
    required this.name,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool themeCondition = context.read<ThemeCubit>().isLightMode;
    return Text(
      name,
      style: TextStyle(
        color:
            isSelected
                ? (themeCondition
                    ? ColorsManager.whiteColor
                    : ColorsManager.primaryDark)
                : ColorsManager.grey3,
        fontSize:
            isSelected
                ? Styles.textStyle18w5.fontSize
                : Styles.textStyle16w5.fontSize,
      ),
    );
  }
}
