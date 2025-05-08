import 'package:dartz/dartz.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/features/auth/data/models/login_model.dart';
import 'package:electro/features/profile/data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<Failure, UserResponse>> getUserAccount(String token);
  Future<Either<Failure, UserUpdateResponse>> updateUserAccount(
    String name,
    String email,
    String token,
  );

  Future<Either<Failure, UserUpdateResponse>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String token,
  });
}
