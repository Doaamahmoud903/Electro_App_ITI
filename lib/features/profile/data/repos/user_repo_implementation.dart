import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:electro/core/api/api_constant.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/core/errors/models/api_error_model.dart';
import 'package:electro/features/auth/data/models/login_model.dart';
import 'package:electro/features/profile/data/models/user_model.dart';
import 'package:electro/features/profile/data/repos/user_repo.dart';
import 'package:flutter/material.dart';

class UserRepositoryImplement extends UserRepo {
  final ApiService _apiService;
  UserRepositoryImplement(this._apiService);

  // Get User Account
  @override
  Future<Either<Failure, UserResponse>> getUserAccount(token) async {
    try {
      var request = await _apiService.get(
        endPoint: ApiConstant.getUser,
        token: token,
      );
      return right(UserResponse.fromJson(request));
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

  // Update User Account
  @override
  Future<Either<Failure, UserUpdateResponse>> updateUserAccount(
    name,
    email,
    token,
  ) async {
    try {
      var request = await _apiService.put(
        endPoint: ApiConstant.updateUser,
        token: token,
        data: {'name': name, 'email': email},
      );
      return right(UserUpdateResponse.fromJson(request));
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
  Future<Either<Failure, UserUpdateResponse>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    try {
      // Debug prints
      print('Attempting to change password with:');
      print('Current Password: $currentPassword');
      print('New Password: $newPassword');
      print(
        'Token: ${token.substring(0, 20)}...',
      ); // Show partial token for security

      // Create Dio instance with proper configuration
      final dio = Dio(
        BaseOptions(
          baseUrl:
              'https://e-commerce-node-seven.vercel.app/api/v1', // Replace with your actual base URL
          headers: {'Content-Type': 'application/json', 'token': token},
          validateStatus:
              (status) => status! < 500, // Accept status codes < 500
        ),
      );

      // Make the request
      final response = await dio.put(
        '/users/change-password', // Full endpoint path
        data: {"currentPassword": currentPassword, "newPassword": newPassword},
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      return Right(UserUpdateResponse.fromJson(response.data));
    } on DioException catch (error) {
      print('DioError: ${error.message}');
      print('Response: ${error.response?.data}');
      print('Status Code: ${error.response?.statusCode}');

      if (error.response != null) {
        return Left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return Left(ServerFailure('Network error: ${error.message}'));
      }
    } catch (error) {
      print('Unexpected error: $error');
      return Left(ServerFailure('Something went wrong: ${error.toString()}'));
    }
  }
}
