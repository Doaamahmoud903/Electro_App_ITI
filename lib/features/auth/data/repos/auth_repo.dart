import 'package:dartz/dartz.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/features/auth/data/models/login_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginResponseModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, SignUpModel>> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String address,
  });

  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword({
    required String email,
  });

  Future<Either<Failure, ForgetPasswordResponse>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  });
}
