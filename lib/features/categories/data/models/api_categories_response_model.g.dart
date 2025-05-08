// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_categories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) =>
    CategoriesResponse(
      message: json['message'] as String?,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList(),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'categories': instance.categories,
      'success': instance.success,
    };

CategoryProductsModel _$CategoryProductsModelFromJson(
  Map<String, dynamic> json,
) => CategoryProductsModel(
  message: json['message'] as String?,
  success: json['success'] as bool?,
  products:
      (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
  page: (json['page'] as num?)?.toInt(),
  totalProducts: (json['totalProducts'] as num?)?.toInt(),
);

Map<String, dynamic> _$CategoryProductsModelToJson(
  CategoryProductsModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'success': instance.success,
  'products': instance.products,
  'page': instance.page,
  'totalProducts': instance.totalProducts,
};

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    slug: json['slug'] as String?,
    customId: json['customId'] as String?,
    createdBy: json['createdBy'] as String?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
  )
  ..image =
      json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'image': instance.image,
  '_id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'customId': instance.customId,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
  secureUrl: json['secure_url'] as String?,
  publicId: json['public_id'] as String?,
);

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
  'secure_url': instance.secureUrl,
  'public_id': instance.publicId,
};
