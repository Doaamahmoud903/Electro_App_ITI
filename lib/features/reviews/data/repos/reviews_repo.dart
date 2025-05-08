import 'package:dartz/dartz.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/features/reviews/data/models/reviews_model.dart';

abstract class ReviewsRepo {
  Future<Either<Failure, ReviewResponse>> addReview(
    String token,
    String productId,
    String comment,
    int rate,
  );
  Future<Either<Failure, DeleteReviewsResponse>> deleteReview(
    String orderId,
    String token,
  );
}
