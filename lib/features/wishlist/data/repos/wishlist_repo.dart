import 'package:dartz/dartz.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/features/wishlist/data/models/wishlist_model.dart';

abstract class WishlistRepo {
  Future<Either<Failure, WishlistGetModel>> getLoggedWishlsit({
    required String token,
  });

  Future<Either<Failure, WishlistAddModel>> addToWishlsit({
    required String productId,
    required String token,
  });

  Future<Either<Failure, WishlistAddModel>> deleteFromWishlsit({
    required String productId,
    required String token,
  });

  Future<Either<Failure, WishlistAddModel>> clearWishlsit({
    required String token,
  });
}
