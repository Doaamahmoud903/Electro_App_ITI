import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:electro/core/api/api_constant.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/core/errors/models/api_error_model.dart';
import 'package:electro/features/reviews/data/models/reviews_model.dart';
import 'package:electro/features/reviews/data/repos/reviews_repo.dart';

class ReviewsRepoImplementation extends ReviewsRepo {
  final ApiService _apiService;
  ReviewsRepoImplementation(this._apiService);

  @override
  Future<Either<Failure, ReviewResponse>> addReview(
    token,
    productId,
    comment,
    rate,
  ) async {
    try {
      var request = await _apiService.post(
        endPoint: ApiConstant.addReview.replaceAll(":productId", productId),
        token: token,
        data: {"comment": comment, "rate": rate},
      );
      return right(ReviewResponse.fromJson(request));
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
  Future<Either<Failure, DeleteReviewsResponse>> deleteReview(
    token,
    orderId,
  ) async {
    try {
      var request = await _apiService.delete(
        endPoint: ApiConstant.updateUser.replaceAll(":orderId", orderId),
        token: token,
      );
      return right(DeleteReviewsResponse.fromJson(request));
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
