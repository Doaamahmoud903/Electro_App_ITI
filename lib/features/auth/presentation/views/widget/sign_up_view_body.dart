import 'package:dio/dio.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/app_logo.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';
import 'package:electro/core/widgets/intro_app_logo.dart';
import 'package:electro/features/auth/data/repos/auth_repo_implemtation.dart';
import 'package:electro/features/auth/presentation/manager/auth_cubit.dart';
import 'package:electro/features/auth/presentation/manager/auth_state.dart';
import 'package:electro/features/layout/presentation/views/widgets/second_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/widgets/custom_button.dart';
import 'package:electro/core/widgets/custom_text_field.dart';

import '../../../../../core/functions/validators.dart';

class SignUpViewBody extends StatelessWidget {
  SignUpViewBody({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final bool isLightMode = context.read<ThemeCubit>().isLightMode;
    final Color colorCondition =
        isLightMode ? ColorsManager.primaryDark : ColorsManager.primaryLight;

    return Scaffold(
      appBar: SecondAppbar(name: StringManager.register.tr(context)),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider(
          create:
              (_) => AuthCubit(
                AuthRepositoryImplementation(apiService: ApiService(Dio())),
              ),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is SignupSuccess) {
                ToastUtils.showSuccessToast(
                  StringManager.registerSuccess.tr(context),
                );

                GoRouter.of(context).pushReplacementNamed(Routes.login);
              } else if (state is AuthFailure) {
                print(state.error);
                ToastUtils.showErrorToast(
                  "${StringManager.registerFailed.tr(context)}: ${state.error}",
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [IntroAppLogo()],
                        ),
                        SizedBox(height: height * 0.02),

                        // Name Field
                        CustomTextField(
                          controller: nameController,
                          hintText: StringManager.name.tr(context),
                          hintColor: ColorsManager.grey2,
                          prefixIcon: ImagesAssets.userIcon,
                          prefixColor: ColorsManager.grey2,
                          fillColor: Colors.transparent,
                          borderColor: ColorsManager.primary,
                          borderRadius: 12,
                          validator: Validators.validateName,
                        ),
                        SizedBox(height: height * 0.02),

                        // Email Field
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

                        // Password Field
                        CustomTextField(
                          controller: passwordController,
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

                        // Confirm Password Field
                        CustomTextField(
                          controller: confirmPasswordController,
                          hintText: StringManager.rePassword.tr(context),
                          hintColor: ColorsManager.grey2,
                          prefixIcon: ImagesAssets.lockIcon,
                          prefixColor: ColorsManager.grey2,
                          fillColor: Colors.transparent,
                          borderColor: ColorsManager.primary,
                          borderRadius: 12,
                          isPassword: true,
                          validator: (value) => Validators.validateConfirmPassword(value, passwordController.text),
                        ),
                        SizedBox(height: height * 0.02),

                        // Address Field
                        CustomTextField(
                          controller: addressController,
                          hintText: StringManager.address.tr(context),
                          hintColor: ColorsManager.grey2,
                          prefixIcon: ImagesAssets.mapIcon,
                          prefixColor: ColorsManager.grey2,
                          fillColor: Colors.transparent,
                          borderColor: ColorsManager.primary,
                          borderRadius: 12,
                          validator: Validators.validateAddress,
                        ),
                        SizedBox(height: height * 0.02),

                        // Phone Field
                        CustomTextField(
                          controller: phoneController,
                          hintText: StringManager.phoneNumber.tr(context),
                          hintColor: ColorsManager.grey2,
                          prefixIcon: ImagesAssets.phoneIcon,
                          prefixColor: ColorsManager.grey2,
                          fillColor: Colors.transparent,
                          borderColor: ColorsManager.primary,
                          borderRadius: 12,
                          keyboardType: TextInputType.phone,
                          validator: Validators.validatePhone,
                        ),
                        SizedBox(height: height * 0.03),

                        // Sign Up Button
                        state is AuthLoading
                            ? const Center(child: CustomLoadingItem())
                            : CustomButton(
                              text: StringManager.register.tr(context),
                              backgroundColor: ColorsManager.primary,
                              textColor: ColorsManager.whiteColor,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final nameError = Validators.validateName(nameController.text);
                                  final emailError = Validators.validateEmail(emailController.text);
                                  final passwordError = Validators.validatePassword(passwordController.text);
                                  final confirmPasswordError = Validators.validateConfirmPassword(
                                      confirmPasswordController.text, passwordController.text);
                                  final addressError = Validators.validateAddress(addressController.text);
                                  final phoneError = Validators.validatePhone(phoneController.text);

                                  if (nameError != null) {
                                    ToastUtils.showErrorToast(nameError);
                                  } else if (emailError != null) {
                                    ToastUtils.showErrorToast(emailError);
                                  } else if (passwordError != null) {
                                    ToastUtils.showErrorToast(passwordError);
                                  } else if (confirmPasswordError != null) {
                                    ToastUtils.showErrorToast(confirmPasswordError);
                                  } else if (addressError != null) {
                                    ToastUtils.showErrorToast(addressError);
                                  } else if (phoneError != null) {
                                    ToastUtils.showErrorToast(phoneError);
                                  } else {
                                    AuthCubit.get(context).signup(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      confirmPassword:
                                      confirmPasswordController.text,
                                      address: addressController.text,
                                      phone: phoneController.text,
                                    );
                                  }

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
