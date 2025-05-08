import 'package:json_annotation/json_annotation.dart';

part 'wishlist_model.g.dart';

@JsonSerializable()
class WishlistAddModel {
  final String? message;
  final WishlistModel? wishlist;
  final bool? success;

  WishlistAddModel({this.message, this.wishlist, this.success});

  factory WishlistAddModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistAddModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistAddModelToJson(this);
}

@JsonSerializable()
class WishlistModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? user;
  final List<Product>? products;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;

  WishlistModel({
    this.id,
    this.user,
    this.products,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistModelToJson(this);
}

@JsonSerializable()
class WishlistGetModel {
  final String? message;
  final WishlistModel? wishlist;
  final bool? success;
  final int? count;

  WishlistGetModel({this.message, this.wishlist, this.success, this.count});

  factory WishlistGetModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistGetModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistGetModelToJson(this);
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
  final String? category;
  final String? brand;
  final String? customId;
  final List<ProductImage>? images;
  final int? stock;
  final int? sold;
  final double? rateAvg;
  final int? rateNum;
  final String? createdAt;
  final String? updatedAt;
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
