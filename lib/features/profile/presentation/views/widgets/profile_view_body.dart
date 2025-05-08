import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/custom_button.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';
import 'package:electro/features/layout/presentation/views/widgets/second_appbar.dart';
import 'package:electro/features/profile/presentation/manager/user_cubit.dart';
import 'package:electro/features/profile/presentation/manager/user_state.dart';
import 'package:electro/features/profile/presentation/views/widgets/user_details.dart';
import 'package:electro/features/profile/presentation/views/widgets/user_profile_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late String? token;
  late TextEditingController emailController;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    token = CacheHelper().getData("token");
    emailController = TextEditingController();
    nameController = TextEditingController();

    if (token != null) {
      context.read<UserCubit>().getUserAccount(token!);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final bool isLightMode = themeCubit.isLightMode;
    final Color colorCondition =
        isLightMode ? ColorsManager.primaryDark : ColorsManager.whiteColor;
    final token = CacheHelper().getData("token");
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: SecondAppbar(name: StringManager.profile.tr(context)),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UpdateUserSuccess) {
            ToastUtils.showSuccessToast(
              StringManager.updateSuccess.tr(context),
            );
          }
          if (state is UpdateUserFailure) {
            ToastUtils.showErrorToast(state.error);
          }
        },
        builder: (context, state) {
          final userCubit = context.read<UserCubit>();

          if (state is GetUserLoading) {
            return const CustomLoadingItem();
          }

          if (state is GetUserFailure) {
            ToastUtils.showErrorToast(state.error);
          }

          // Update controllers when data loads
          if (state is GetUserSuccess) {
            nameController.text = userCubit.name;
            emailController.text = userCubit.email;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  UserDetails(name: userCubit.name, email: userCubit.email),
                  UserProfileDetails(
                    labelText: StringManager.name.tr(context),
                    initialText: userCubit.name,
                    onChanged: userCubit.updateName,
                    textController: nameController,
                  ),
                  SizedBox(height: height * 0.02),
                  UserProfileDetails(
                    labelText: StringManager.email.tr(context),
                    initialText: userCubit.email,
                    onChanged: userCubit.updateEmail,
                    textController: emailController,
                  ),
                  SizedBox(height: height * 0.04),
                  if (state is UpdateUserLoading)
                    const CustomLoadingItem()
                  else
                    CustomButton(
                      onPressed: () {
                        if (token != null) {
                          userCubit.updateUserAccount(
                            name: userCubit.name,
                            email: userCubit.email,
                            token: token,
                          );
                        }
                      },
                      text: StringManager.updateProfile.tr(context),
                      backgroundColor: ColorsManager.primaryLight,
                      textColor: ColorsManager.whiteColor,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
