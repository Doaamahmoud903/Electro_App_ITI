// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteReviewsResponse _$DeleteReviewsResponseFromJson(
  Map<String, dynamic> json,
) => DeleteReviewsResponse(
  message: json['message'] as String?,
  success: json['success'] as bool?,
);

Map<String, dynamic> _$DeleteReviewsResponseToJson(
  DeleteReviewsResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'success': instance.success,
};

ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) =>
    ReviewResponse(
      message: json['message'] as String?,
      review:
          json['review'] == null
              ? null
              : Review.fromJson(json['review'] as Map<String, dynamic>),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$ReviewResponseToJson(ReviewResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'review': instance.review,
      'success': instance.success,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
  id: json['id'] as String?,
  comment: json['comment'] as String?,
  rate: (json['rate'] as num?)?.toInt(),
  productId: json['productId'] as String?,
  createdBy: json['createdBy'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  'comment': instance.comment,
  'rate': instance.rate,
  'productId': instance.productId,
  'createdBy': instance.createdBy,
  'id': instance.id,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
