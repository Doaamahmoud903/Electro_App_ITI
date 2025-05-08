import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:electro/core/api/api_constant.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/core/errors/models/api_error_model.dart';
import 'package:electro/features/auth/data/models/login_model.dart';
import 'package:electro/features/auth/data/repos/auth_repo.dart';

class AuthRepositoryImplementation extends AuthRepo {
  final ApiService _apiService;
  AuthRepositoryImplementation({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<Either<Failure, LoginResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(
        endPoint: ApiConstant.login,
        data: {"email": email, "password": password},
      );
      print('Response Data: ${response.toString()}');
      return Right(LoginResponseModel.fromJson(response));
    } catch (error) {
      if (error is DioException) {
        return left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, SignUpModel>> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String address,
  }) async {
    try {
      final response = await _apiService.post(
        endPoint: ApiConstant.signup,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "phone": phone,
          "address": address,
        },
      );
      return Right(SignUpModel.fromJson(response));
    } catch (error) {
      if (error is DioException) {
        return left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword({
    required String email,
  }) async {
    try {
      final response = await _apiService.post(
        endPoint: ApiConstant.forgetPassword,
        data: {"email": email},
      );
      return Right(ForgetPasswordResponse.fromJson(response));
    } catch (error) {
      if (error is DioException) {
        return left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordResponse>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.put(
        endPoint: ApiConstant.resetPassword,
        data: {"email": email, "code": code, "newPassword": newPassword},
      );
      return Right(ForgetPasswordResponse.fromJson(response));
    } catch (error) {
      if (error is DioException) {
        return left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }
}
