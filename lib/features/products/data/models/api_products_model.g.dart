// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) =>
    ProductsModel(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList(),
      page: (json['page'] as num?)?.toInt(),
      totalProducts: (json['totalProducts'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductsModelToJson(ProductsModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'products': instance.products,
      'page': instance.page,
      'totalProducts': instance.totalProducts,
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
  category:
      json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
  brand:
      json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
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
  reviews:
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
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
  'reviews': instance.reviews,
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

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
  id: json['_id'] as String?,
  comment: json['comment'] as String?,
  productId: json['productId'] as String?,
  createdBy:
      json['createdBy'] == null
          ? null
          : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  '_id': instance.id,
  'comment': instance.comment,
  'productId': instance.productId,
  'createdBy': instance.createdBy,
};

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  slug: json['slug'] as String?,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
};

Brand _$BrandFromJson(Map<String, dynamic> json) =>
    Brand(id: json['_id'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
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

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) =>
    CreatedBy(id: json['id'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
