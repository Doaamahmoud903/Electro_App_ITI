import 'package:electro/features/auth/data/models/login_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String token;
  LoginSuccess({required this.token});
}

class LoginFailure extends AuthState {
  final String error;
  LoginFailure(this.error);
}

class LogoutSuccess extends AuthState {}

class LogoutFailure extends AuthState {
  final String error;
  LogoutFailure(this.error);
}

class SignupSuccess extends AuthState {
  final SignUpModel signupResponse;
  SignupSuccess(this.signupResponse);
}

class ForgetPasswordSuccess extends AuthState {
  final ForgetPasswordResponse forgetPasswordResponse;
  ForgetPasswordSuccess(this.forgetPasswordResponse);
}

class ResetPasswordSuccess extends AuthState {
  final ForgetPasswordResponse resetPasswordResponse;
  ResetPasswordSuccess(this.resetPasswordResponse);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
