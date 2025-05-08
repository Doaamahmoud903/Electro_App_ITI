// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistAddModel _$WishlistAddModelFromJson(Map<String, dynamic> json) =>
    WishlistAddModel(
      message: json['message'] as String?,
      wishlist:
          json['wishlist'] == null
              ? null
              : WishlistModel.fromJson(
                json['wishlist'] as Map<String, dynamic>,
              ),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$WishlistAddModelToJson(WishlistAddModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'wishlist': instance.wishlist,
      'success': instance.success,
    };

WishlistModel _$WishlistModelFromJson(Map<String, dynamic> json) =>
    WishlistModel(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList(),
      active: json['active'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$WishlistModelToJson(WishlistModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'products': instance.products,
      'active': instance.active,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

WishlistGetModel _$WishlistGetModelFromJson(Map<String, dynamic> json) =>
    WishlistGetModel(
      message: json['message'] as String?,
      wishlist:
          json['wishlist'] == null
              ? null
              : WishlistModel.fromJson(
                json['wishlist'] as Map<String, dynamic>,
              ),
      success: json['success'] as bool?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WishlistGetModelToJson(WishlistGetModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'wishlist': instance.wishlist,
      'success': instance.success,
      'count': instance.count,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  slug: json['slug'] as String?,
  createdBy: json['createdBy'] as String?,
  imageCover:
      json['imageCover'] == null
          ? null
          : ImageCover.fromJson(json['imageCover'] as Map<String, dynamic>),
  price: (json['price'] as num?)?.toDouble(),
  discount: (json['discount'] as num?)?.toInt(),
  priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toDouble(),
  category: json['category'] as String?,
  brand: json['brand'] as String?,
  customId: json['customId'] as String?,
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
  stock: (json['stock'] as num?)?.toInt(),
  sold: (json['sold'] as num?)?.toInt(),
  rateAvg: (json['rateAvg'] as num?)?.toDouble(),
  rateNum: (json['rateNum'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'slug': instance.slug,
  'imageCover': instance.imageCover,
  'price': instance.price,
  'discount': instance.discount,
  'priceAfterDiscount': instance.priceAfterDiscount,
  'category': instance.category,
  'brand': instance.brand,
  'customId': instance.customId,
  'images': instance.images,
  'stock': instance.stock,
  'sold': instance.sold,
  'rateAvg': instance.rateAvg,
  'rateNum': instance.rateNum,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'createdBy': instance.createdBy,
};

ImageCover _$ImageCoverFromJson(Map<String, dynamic> json) => ImageCover(
  secureUrl: json['secure_url'] as String?,
  publicId: json['public_id'] as String?,
);

Map<String, dynamic> _$ImageCoverToJson(ImageCover instance) =>
    <String, dynamic>{
      'secure_url': instance.secureUrl,
      'public_id': instance.publicId,
    };

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) => ProductImage(
  id: json['_id'] as String?,
  secureUrl: json['secure_url'] as String?,
  publicId: json['public_id'] as String?,
);

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'secure_url': instance.secureUrl,
      'public_id': instance.publicId,
    };
