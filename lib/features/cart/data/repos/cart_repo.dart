import 'package:dartz/dartz.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/features/cart/data/models/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failure, AllLoggedCartModel>> getLoggedCart({
    required String token,
  });

  Future<Either<Failure, CartAddModel>> addToCart({
    required String productId,
    required String token,
  });

  Future<Either<Failure, CartUpdateModel>> updateQuantity({
    required String productId,
    required String token,
    required int quantity,
  });

  Future<Either<Failure, CartUpdateModel>> deleteFromCart({
    required String productId,
    required String token,
  });

  Future<Either<Failure, CartAddModel>> clearCart({required String token});
}
