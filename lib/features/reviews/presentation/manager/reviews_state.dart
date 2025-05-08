import 'package:equatable/equatable.dart';
import 'package:electro/features/reviews/data/models/reviews_model.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];

  get message => null;
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class AddReviewSuccess extends ReviewState {
  final ReviewResponse response;

  const AddReviewSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class DeleteReviewSuccess extends ReviewState {
  final DeleteReviewsResponse response;

  const DeleteReviewSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ReviewFailure extends ReviewState {
  final String error;

  const ReviewFailure(this.error);

  @override
  List<Object?> get props => [error];
}
