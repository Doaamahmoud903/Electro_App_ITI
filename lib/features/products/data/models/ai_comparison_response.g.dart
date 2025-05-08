// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_comparison_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComparisonResponse _$ComparisonResponseFromJson(Map<String, dynamic> json) =>
    ComparisonResponse(
      comparison:
          (json['comparison'] as List<dynamic>)
              .map((e) => ComparisonItem.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ComparisonResponseToJson(ComparisonResponse instance) =>
    <String, dynamic>{'comparison': instance.comparison};

ComparisonItem _$ComparisonItemFromJson(Map<String, dynamic> json) =>
    ComparisonItem(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      brand: json['brand'] as String,
      category: json['category'] as String,
      discount: (json['discount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ComparisonItemToJson(ComparisonItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'description': instance.description,
      'brand': instance.brand,
      'category': instance.category,
      'discount': instance.discount,
    };
