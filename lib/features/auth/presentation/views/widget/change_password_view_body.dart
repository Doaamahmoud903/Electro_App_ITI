import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/custom_text_field.dart';
import 'package:electro/features/layout/presentation/views/widgets/second_appbar.dart';
import 'package:electro/features/profile/presentation/manager/user_cubit.dart';
import 'package:electro/features/profile/presentation/manager/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key});

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String token = CacheHelper().getData('token');
    final themeCubit = context.read<ThemeCubit>();
    final bool isLightMode = themeCubit.isLightMode;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: SecondAppbar(name: StringManager.changePassword.tr(context)),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is ChangePasswordFailure) {
            ToastUtils.showErrorToast(state.error);
          } else if (state is ChangePasswordSuccess) {
            ToastUtils.showSuccessToast(state.changePasswordResponse.message!);
            // Clear the text fields after successful password change
            oldPasswordController.clear();
            newPasswordController.clear();
            context.pop();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Text(
                    StringManager.oldPassword.tr(context),
                    style: TextStyle(
                      color:
                          isLightMode
                              ? ColorsManager.primaryDark
                              : ColorsManager.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: CustomTextField(
                    controller: oldPasswordController,
                    isPassword: true,
                    fillColor: Colors.transparent,
                    prefixColor:
                        isLightMode
                            ? ColorsManager.primaryDark
                            : ColorsManager.whiteColor,
                    prefixIcon: ImagesAssets.lockIcon,

                    borderRadius: 15,
                    suffixColor:
                        isLightMode
                            ? ColorsManager.primaryDark
                            : ColorsManager.whiteColor,
                    borderColor:
                        isLightMode
                            ? ColorsManager.primaryDark
                            : ColorsManager.whiteColor,
                  ),
                ),
                SizedBox(height: height * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Text(
                    StringManager.newPassword.tr(context),
                    style: TextStyle(
                      color:
                          isLightMode
                              ? ColorsManager.primaryDark
                              : ColorsManager.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: CustomTextField(
                    controller: newPasswordController,
                    isPassword: true,
                    fillColor: Colors.transparent,
                    prefixColor:
                        isLightMode
                            ? ColorsManager.primaryDark
                            : ColorsManager.whiteColor,
                    prefixIcon: ImagesAssets.lockIcon,

                    borderRadius: 15,
                    suffixColor:
                        isLightMode
                            ? ColorsManager.primaryDark
                            : ColorsManager.whiteColor,
                    borderColor:
                        isLightMode
                            ? ColorsManager.primaryDark
                            : ColorsManager.whiteColor,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          state is ChangePasswordLoading
                              ? null
                              : () {
                                final oldPassword =
                                    oldPasswordController.text.trim();
                                final newPassword =
                                    newPasswordController.text.trim();

                                // Validate password length
                                if (oldPassword.isEmpty ||
                                    newPassword.isEmpty) {
                                  ToastUtils.showErrorToast(
                                    StringManager.fillInAllFields.tr(context),
                                  );
                                  return;
                                }

                                if (newPassword.length < 6) {
                                  ToastUtils.showErrorToast(
                                    StringManager
                                        .passwordMustBeAtLeast6Characters
                                        .tr(context),
                                  );
                                  return;
                                }

                                context.read<UserCubit>().changePassword(
                                  currentPassword: oldPassword,
                                  newPassword: newPassword,
                                  token: token,
                                );
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child:
                          state is ChangePasswordLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
                                StringManager.changePassword.tr(context),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorsManager.whiteColor,
                                ),
                              ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
