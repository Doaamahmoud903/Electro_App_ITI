import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:electro/core/api/api_constant.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/core/errors/models/api_error_model.dart';
import 'package:electro/features/orders/data/models/orders_model.dart';

import 'package:electro/features/orders/data/repos/orders_repo.dart';

class OrdersRepositoryImplementation extends OrdersRepo {
  final ApiService _apiService;
  OrdersRepositoryImplementation({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<Either<Failure, GetOrderResponse>> getOrders({
    required String token,
  }) async {
    try {
      final response = await _apiService.get(
        endPoint: ApiConstant.orders,
        token: token,
      );
      return right(GetOrderResponse.fromJson(response));
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
  Future<Either<Failure, CreateOrder>> createOrders({
    required String token,
    required String cartId,
    required ShoppingAddress shoppingAddress,
  }) async {
    try {
      final response = await _apiService.post(
        endPoint: ApiConstant.orderCreated.replaceAll(":cartId", cartId),
        token: token,
        data: {"shoppingAddress": shoppingAddress.toJson()},
      );
      return right(CreateOrder.fromJson(response['order']));
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
  Future<Either<Failure, DeleteOrderResponse>> deleteOrder({
    required String token,
    required String orderId,
  }) async {
    try {
      final response = await _apiService.delete(
        endPoint: ApiConstant.orderDeleted.replaceAll(":orderId", orderId),
        token: token,
      );
      return right(DeleteOrderResponse.fromJson(response));
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
