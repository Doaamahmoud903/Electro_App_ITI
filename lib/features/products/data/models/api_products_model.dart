import 'package:json_annotation/json_annotation.dart';

part 'api_products_model.g.dart';

@JsonSerializable()
class ProductsModel {
  final String? message;
  final bool? success;
  final List<Product>? products;
  final int? page;
  final int? totalProducts;

  ProductsModel({
    this.message,
    this.success,
    this.products,
    this.page,
    this.totalProducts,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "_id")
  final String? id;
  final String? title;
  final String? description;
  final String? slug;
  final ImageCover? imageCover;
  final double? price;
  final int? discount;
  final double? priceAfterDiscount;
  final Category? category;
  final Brand? brand;
  final String? customId;
  final List<ProductImage>? images;
  final int? stock;
  final int? sold;
  final double? rateAvg;
  final int? rateNum;
  final String? createdAt;
  final String? updatedAt;
  final List<Review>? reviews;
  final String? createdBy;

  Product({
    this.id,
    this.title,
    this.description,
    this.slug,
    this.createdBy,
    this.imageCover,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.category,
    this.brand,
    this.customId,
    this.images,
    this.stock,
    this.sold,
    this.rateAvg,
    this.rateNum,
    this.createdAt,
    this.updatedAt,
    this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ImageCover {
  @JsonKey(name: "secure_url")
  final String? secureUrl;
  @JsonKey(name: "public_id")
  final String? publicId;

  ImageCover({this.secureUrl, this.publicId});

  factory ImageCover.fromJson(Map<String, dynamic> json) =>
      _$ImageCoverFromJson(json);
  Map<String, dynamic> toJson() => _$ImageCoverToJson(this);
}

@JsonSerializable()
class Review {
  @JsonKey(name: "_id")
  final String? id;
  final String? comment;
  final String? productId;
  final CreatedBy? createdBy;

  Review({this.id, this.comment, this.productId, this.createdBy});

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "_id")
  final String? id;
  final String? name;
  final String? slug;

  Category({this.id, this.name, this.slug});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Brand {
  @JsonKey(name: "_id")
  final String? id;
  final String? name;

  Brand({this.id, this.name});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class ProductImage {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "secure_url")
  final String? secureUrl;
  @JsonKey(name: "public_id")
  final String? publicId;

  ProductImage({this.id, this.secureUrl, this.publicId});

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}

@JsonSerializable()
class CreatedBy {
  final String? id;
  final String? name;

  CreatedBy({this.id, this.name});

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);
  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
}
