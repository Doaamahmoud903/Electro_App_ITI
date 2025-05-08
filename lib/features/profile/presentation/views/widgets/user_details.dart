import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/features/profile/presentation/views/widgets/user_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetails extends StatelessWidget {
  final String name;
  final String email;

  const UserDetails({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool themeCondition = context.read<ThemeCubit>().isLightMode;
    Color titleColor =
        themeCondition ? ColorsManager.primaryDark : ColorsManager.whiteColor;
    Color subtitleColor =
        themeCondition ? Colors.black : ColorsManager.whiteColor;

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${StringManager.welcome.tr(context)}, $name',
                style: TextStyle(color: titleColor, fontSize: 20),
              ),
              Text(email, style: TextStyle(color: subtitleColor, fontSize: 14)),
            ],
          ),
        ),
        const Spacer(),
        const UserCircleImage(),
      ],
    );
  }
}
