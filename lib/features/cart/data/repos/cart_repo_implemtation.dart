import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:electro/core/api/api_constant.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/core/errors/models/api_error_model.dart';

import 'package:electro/features/cart/data/models/cart_model.dart';
import 'package:electro/features/cart/data/repos/cart_repo.dart';

class CartRepoImplemtation extends CartRepo {
  final ApiService _apiService;
  CartRepoImplemtation({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<Either<Failure, AllLoggedCartModel>> getLoggedCart({
    required String token,
  }) async {
    try {
      final response = await _apiService.get(
        endPoint: ApiConstant.cart,
        token: token,
      );
      return right(AllLoggedCartModel.fromJson(response));
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
  Future<Either<Failure, CartAddModel>> addToCart({
    required String productId,
    required String token,
  }) async {
    try {
      final response = await _apiService.post(
        endPoint: ApiConstant.cart,
        data: {'productId': productId},
        token: token,
      );
      return right(CartAddModel.fromJson(response));
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
  Future<Either<Failure, CartUpdateModel>> updateQuantity({
    required String productId,
    required String token,
    required int quantity,
  }) async {
    try {
      final response = await _apiService.put(
        endPoint: ApiConstant.updateQuantity.replaceAll(":id", productId),
        data: {'quantity': quantity},
        token: token,
      );
      return right(CartUpdateModel.fromJson(response));
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
  Future<Either<Failure, CartUpdateModel>> deleteFromCart({
    required String productId,
    required String token,
  }) async {
    try {
      final response = await _apiService.delete(
        endPoint: ApiConstant.deleteFromCart.replaceAll(":id", productId),
        token: token,
      );
      return right(CartUpdateModel.fromJson(response));
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
  Future<Either<Failure, CartAddModel>> clearCart({
    required String token,
  }) async {
    try {
      final response = await _apiService.put(
        endPoint: ApiConstant.cart,
        token: token,
        data: {},
      );
      return right(CartAddModel.fromJson(response));
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
