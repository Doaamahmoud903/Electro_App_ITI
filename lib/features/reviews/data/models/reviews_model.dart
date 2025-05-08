import 'package:json_annotation/json_annotation.dart';
part 'reviews_model.g.dart';

@JsonSerializable()
class DeleteReviewsResponse {
  final String? message;
  final bool? success;

  DeleteReviewsResponse({this.message, this.success});

  factory DeleteReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteReviewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteReviewsResponseToJson(this);
}

@JsonSerializable()
class ReviewResponse {
  final String? message;
  final Review? review;
  final bool? success;

  ReviewResponse({this.message, this.review, this.success});

  factory ReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewResponseToJson(this);
}

@JsonSerializable()
class Review {
  final String? comment;
  final int? rate;
  final String? productId;
  final String? createdBy;
  final String? id;
  final String? createdAt;
  final String? updatedAt;

  Review({
    @JsonKey(name: '_id') required this.id,
    this.comment,
    this.rate,
    this.productId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
