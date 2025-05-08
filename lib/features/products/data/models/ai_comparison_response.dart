import 'package:json_annotation/json_annotation.dart';
part 'ai_comparison_response.g.dart';

@JsonSerializable()
class ComparisonResponse {
  final List<ComparisonItem> comparison;

  ComparisonResponse({required this.comparison});

  factory ComparisonResponse.fromJson(Map<String, dynamic> json) =>
      _$ComparisonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComparisonResponseToJson(this);
}

@JsonSerializable()
class ComparisonItem {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  final String brand;
  final String category;
  final double? discount;

  ComparisonItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.brand,
    required this.category,
    this.discount,
  });

  factory ComparisonItem.fromJson(Map<String, dynamic> json) =>
      _$ComparisonItemFromJson(json);

  Map<String, dynamic> toJson() => _$ComparisonItemToJson(this);
}
