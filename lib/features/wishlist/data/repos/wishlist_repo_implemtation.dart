import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:electro/core/api/api_constant.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/core/errors/models/api_error_model.dart';
import 'package:electro/features/wishlist/data/models/wishlist_model.dart';
import 'package:electro/features/wishlist/data/repos/wishlist_repo.dart';

class WishlistRepositoryImple extends WishlistRepo {
  final ApiService _apiService;
  WishlistRepositoryImple({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<Either<Failure, WishlistGetModel>> getLoggedWishlsit({
    required String token,
  }) async {
    try {
      final response = await _apiService.get(
        endPoint: ApiConstant.wishlist,
        token: token,
      );
      return right(WishlistGetModel.fromJson(response));
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
  Future<Either<Failure, WishlistAddModel>> addToWishlsit({
    required String productId,
    required String token,
  }) async {
    try {
      final response = await _apiService.post(
        endPoint: ApiConstant.wishlist,
        data: {'productId': productId},
        token: token,
      );
      print(response);
      return right(WishlistAddModel.fromJson(response));
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
  Future<Either<Failure, WishlistAddModel>> deleteFromWishlsit({
    required String productId,
    required String token,
  }) async {
    try {
      final response = await _apiService.delete(
        endPoint: ApiConstant.deleteFromWishlsit.replaceAll(":id", productId),
        token: token,
      );
      return right(WishlistAddModel.fromJson(response));
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
  Future<Either<Failure, WishlistAddModel>> clearWishlsit({
    required String token,
  }) async {
    try {
      final response = await _apiService.put(
        endPoint: ApiConstant.wishlist,
        token: token,
        data: {},
      );
      return right(WishlistAddModel.fromJson(response));
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
