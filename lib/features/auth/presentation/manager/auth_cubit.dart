import 'dart:developer';
import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/features/auth/data/models/login_model.dart';
import 'package:electro/features/auth/data/repos/auth_repo_implemtation.dart';
import 'package:electro/features/auth/presentation/manager/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryImplementation authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  // Login method
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final response = await authRepository.login(
      email: email,
      password: password,
    );
    print(response);
    response.fold(
      (failure) {
        emit(AuthFailure(failure.errMessage));
      },
      (loginResponse) async {
        UserModel user = loginResponse.user!;
        print("User: ${user.toString()}");
        log(user.toString());

        final token = loginResponse.token;
        final userJson = loginResponse.user!.toJson();
        await CacheHelper().saveData('token', token);
        await CacheHelper().saveData('user', userJson);
        emit(LoginSuccess(token: loginResponse.token!));
      },
    );
  }

  //  logout method
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await CacheHelper().removeData('token');
      await CacheHelper().removeData('user');

      emit(LogoutSuccess());
    } catch (error) {
      emit(LogoutFailure(error.toString()));
    }
  }

  /// signup method
  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());
    final response = await authRepository.signup(
      name: name,
      email: email,
      password: password,
      confirmPassword: password,
      phone: phone,
      address: address,
    );
    response.fold(
      (failure) {
        emit(AuthFailure(failure.errMessage));
      },
      (signupResponse) {
        emit(SignupSuccess(signupResponse));
      },
    );
  }

  // /// forget password method
  Future<void> forgetPassword({required String email}) async {
    try {
      emit(AuthLoading());
      final response = await authRepository.forgetPassword(email: email);

      response.fold(
        (failure) {
          emit(AuthFailure(failure.errMessage));
        },
        (forgetPasswordResponse) {
          emit(ForgetPasswordSuccess(forgetPasswordResponse));
        },
      );
    } catch (error) {
      emit(AuthFailure('Something went wrong: ${error.toString()}'));
    }
  }

  // /// reset password method
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    emit(AuthLoading());
    final response = await authRepository.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
    response.fold(
      (failure) {
        emit(AuthFailure(failure.errMessage));
      },
      (resetPasswordResponse) {
        emit(ResetPasswordSuccess(resetPasswordResponse));
      },
    );
  }
}
