import 'package:electro/features/reviews/presentation/manager/reviews_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/reviews/data/repos/reviews_repo.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewsRepo reviewsRepo;
  ReviewCubit(this.reviewsRepo) : super(ReviewInitial());
  Future<void> addReview({
    required String token,
    required String productId,
    required String comment,
    required int rate,
  }) async {
    emit(ReviewLoading());
    final result = await reviewsRepo.addReview(token, productId, comment, rate);

    result.fold(
      (failure) => emit(ReviewFailure(failure.errMessage)),
      (response) => emit(AddReviewSuccess(response)),
    );
  }

  Future<void> deleteReview({
    required String token,
    required String orderId,
  }) async {
    emit(ReviewLoading());

    final result = await reviewsRepo.deleteReview(token, orderId);

    result.fold(
      (failure) => emit(ReviewFailure(failure.errMessage)),
      (response) => emit(DeleteReviewSuccess(response)),
    );
  }
}
