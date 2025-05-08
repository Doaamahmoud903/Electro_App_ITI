import 'package:dio/dio.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/functions/validators.dart';
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
import 'package:electro/google_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/widgets/custom_button.dart';
import 'package:electro/core/widgets/custom_text_field.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final bool isLightMode = context.read<ThemeCubit>().isLightMode;

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
              if (state is LoginSuccess) {
                ToastUtils.showSuccessToast(
                  StringManager.loginSuccess.tr(context),
                );
                GoRouter.of(context).pushReplacementNamed(Routes.layout);
              } else if (state is LoginFailure) {
                ToastUtils.showErrorToast(
                  "${StringManager.loginFailed.tr(context)}: ${state.error}",
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
                        Text(
                          StringManager.login_welcome.tr(context),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                isLightMode
                                    ? ColorsManager.grey3
                                    : ColorsManager.whiteColor,
                          ),
                        ),
                        Text(
                          StringManager.sign_msg.tr(context),
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                isLightMode
                                    ? ColorsManager.grey3
                                    : ColorsManager.whiteColor,
                          ),
                        ),
                        SizedBox(height: height * 0.05),

                        CustomTextField(
                          controller: emailController,
                          hintText: StringManager.email.tr(context),
                          hintColor: ColorsManager.grey2,
                          prefixIcon: ImagesAssets.emailIcon,
                          prefixColor: ColorsManager.grey2,
                          fillColor: Colors.transparent,
                          borderColor: ColorsManager.primary,
                          borderRadius: 12,
                          validator: Validators.validateName,
                        ),
                        SizedBox(height: height * 0.02),
                        CustomTextField(
                          isPassword: true,
                          controller: passwordController,
                          hintText: StringManager.password.tr(context),
                          hintColor: ColorsManager.grey2,
                          hintFontSize: 16,
                          prefixIcon: ImagesAssets.lockIcon,
                          prefixColor: ColorsManager.grey2,
                          fillColor: Colors.transparent,
                          borderColor: ColorsManager.primary,
                          borderRadius: 12,
                          validator: Validators.validatePassword,
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                print(Routes.forgetPasswordView);

                                GoRouter.of(
                                  context,
                                ).push(Routes.forgetPasswordView);
                              },
                              child: Text(
                                StringManager.forget_password_ques.tr(context),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorsManager.primaryLight,
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        state is AuthLoading
                            ? const Center(child: CustomLoadingItem())
                            : CustomButton(
                              text: StringManager.login.tr(context),
                              backgroundColor: ColorsManager.primary,
                              textColor: ColorsManager.whiteColor,
                              onPressed: () {
                                final emailError = Validators.validateEmail(
                                  emailController.text,
                                );
                                final passwordError =
                                    Validators.validatePassword(
                                      passwordController.text,
                                    );

                                if (emailError != null) {
                                  ToastUtils.showErrorToast(emailError);
                                } else if (passwordError != null) {
                                  ToastUtils.showErrorToast(passwordError);
                                } else {
                                  AuthCubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              StringManager.not_have_account_ques.tr(context),
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorsManager.grey3,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.push(Routes.signup);
                              },
                              child: Text(
                                StringManager.createAccount.tr(context),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorsManager.primaryLight,
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.02,
                              ),
                              child: Text(StringManager.or.tr(context)),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        CustomButton(
                          onPressed: () async {
                            final result =
                                await GoogleAuthService().signInWithGoogle();
                            if (result != null) {
                              // Navigate or show success toast
                              ToastUtils.showSuccessToast(
                                "Login successful: ${result.user!.displayName}",
                              );
                            } else {
                              ToastUtils.showErrorToast(
                                "Google sign-in failed",
                              );
                            }
                          },
                          text: StringManager.loginWithGoogle.tr(context),
                          textColor: ColorsManager.primaryLight,
                          fontSize: 18,
                          backgroundColor: ColorsManager.whiteColor,
                          borderColor: ColorsManager.grey2,
                          borderRadius: 12,
                          centerIcon: true,
                          icon: Image.asset(
                            ImagesAssets.googleIcon,
                            width: 24,
                            height: 24,
                          ),
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
