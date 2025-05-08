import 'package:json_annotation/json_annotation.dart';
import 'package:electro/features/products/data/models/api_products_model.dart';
part 'api_categories_response_model.g.dart';

@JsonSerializable()
class CategoriesResponse {
  final String? message;
  final List<Category>? categories;
  final bool? success;

  CategoriesResponse({this.message, this.categories, this.success});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}

@JsonSerializable()
class CategoryProductsModel {
  final String? message;
  final bool? success;
  final List<Product>? products;
  final int? page;
  final int? totalProducts;

  CategoryProductsModel({
    this.message,
    this.success,
    this.products,
    this.page,
    this.totalProducts,
  });

  factory CategoryProductsModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryProductsModelToJson(this);
}

@JsonSerializable()
class Category {
  Image? image;
  @JsonKey(name: "_id")
  final String? id;
  final String? name;
  final String? slug;
  final String? customId;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.customId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Image {
  @JsonKey(name: "secure_url")
  final String? secureUrl;
  @JsonKey(name: "public_id")
  final String? publicId;

  Image({this.secureUrl, this.publicId});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
