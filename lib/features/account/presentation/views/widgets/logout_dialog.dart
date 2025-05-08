import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/features/auth/presentation/manager/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/auth/presentation/manager/auth_cubit.dart';
import 'package:go_router/go_router.dart';

void showLogoutDialog(BuildContext context) {
  bool themeCondition = context.read<ThemeCubit>().isLightMode;
  showDialog(
    context: context,
    builder:
        (context) => BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              Navigator.pop(context);
              GoRouter.of(context).pushReplacement(Routes.logout);
            } else if (state is LogoutFailure) {
              ToastUtils.showErrorToast(state.error);
            }
          },
          builder: (context, state) {
            return AlertDialog(
              backgroundColor:
                  themeCondition
                      ? ColorsManager.whiteColor
                      : ColorsManager.primaryDark,

              title: Text(StringManager.logout.tr(context)),
              content: Text(StringManager.logout_ques.tr(context)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    StringManager.cancel.tr(context),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AuthCubit.get(context).logout();
                  },
                  child: Text(
                    StringManager.logout.tr(context),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ],
            );
          },
        ),
  );
}
