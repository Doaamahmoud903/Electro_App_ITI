import 'package:dartz/dartz.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/features/orders/data/models/orders_model.dart';

abstract class OrdersRepo {
  Future<Either<Failure, GetOrderResponse>> getOrders({required String token});
  Future<Either<Failure, CreateOrder>> createOrders({
    required String token,
    required String cartId,
    required ShoppingAddress shoppingAddress,
  });
  Future<Either<Failure, DeleteOrderResponse>> deleteOrder({
    required String token,
    required String orderId,
  });
}
