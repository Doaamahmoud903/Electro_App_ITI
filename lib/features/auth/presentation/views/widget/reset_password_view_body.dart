import 'package:dio/dio.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/functions/validators.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/app_logo.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';
import 'package:electro/core/widgets/intro_app_logo.dart';
import 'package:electro/features/auth/data/repos/auth_repo_implemtation.dart';
import 'package:electro/features/auth/presentation/manager/auth_cubit.dart';
import 'package:electro/features/auth/presentation/manager/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/widgets/custom_button.dart';
import 'package:electro/core/widgets/custom_text_field.dart';

class ResetPasswordViewBody extends StatelessWidget {
  ResetPasswordViewBody({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider(
          create:
              (_) => AuthCubit(
                AuthRepositoryImplementation(apiService: ApiService(Dio())),
              ),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ResetPasswordSuccess) {
                ToastUtils.showSuccessToast(
                  StringManager.passwordResetSuccess.tr(context),
                );
                GoRouter.of(context).pushReplacementNamed(Routes.login);
              } else if (state is AuthFailure) {
                print(state.error);
                ToastUtils.showErrorToast(
                  "${StringManager.passwordResetFailed.tr(context)}: ${state.error}",
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.06,
                      vertical: height * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [IntroAppLogo()],
                        ),
                        SizedBox(height: height * 0.03),

                        CustomTextField(
                          controller: emailController,
                          hintText: StringManager.email.tr(context),
                          hintColor: ColorsManager.grey2,
                          prefixIcon: ImagesAssets.emailIcon,
                          prefixColor: ColorsManager.grey2,
                          fillColor: Colors.transparent,
                          borderColor: ColorsManager.primary,
                          borderRadius: 12,
                          validator: Validators.validateEmail,
                        ),

                        SizedBox(height: height * 0.02),

                        CustomTextField(
                          controller: codeController,
                          hintText: StringManager.code.tr(context),
                          hintColor: ColorsManager.grey2,
                          prefixIcon: ImagesAssets.plusIcon,
                          prefixColor: ColorsManager.grey2,
                          fillColor: Colors.transparent,
                          borderColor: ColorsManager.primary,
                          borderRadius: 12,
                          keyboardType: TextInputType.number,
                        ),

                        SizedBox(height: height * 0.02),

                        CustomTextField(
                          controller: newPasswordController,
                          hintText: StringManager.password.tr(context),
                          hintColor: ColorsManager.grey2,
                          prefixIcon: ImagesAssets.lockIcon,
                          prefixColor: ColorsManager.grey2,
                          fillColor: Colors.transparent,
                          borderColor: ColorsManager.primary,
                          borderRadius: 12,
                          isPassword: true,
                          validator: Validators.validatePassword,
                        ),

                        SizedBox(height: height * 0.02),

                        state is AuthLoading
                            ? const Center(child: CustomLoadingItem())
                            : CustomButton(
                              text: StringManager.resetPassword.tr(context),
                              backgroundColor: ColorsManager.primary,
                              textColor: ColorsManager.whiteColor,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  AuthCubit.get(context).resetPassword(
                                    email: emailController.text,
                                    code: codeController.text,
                                    newPassword: newPasswordController.text,
                                  );
                                }
                              },
                            ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
