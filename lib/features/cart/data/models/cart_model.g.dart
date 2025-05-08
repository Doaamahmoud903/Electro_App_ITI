// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartAddModel _$CartAddModelFromJson(Map<String, dynamic> json) => CartAddModel(
  message: json['message'] as String?,
  cart:
      json['cart'] == null
          ? null
          : CartModelForAdd.fromJson(json['cart'] as Map<String, dynamic>),
  success: json['success'] as bool?,
);

Map<String, dynamic> _$CartAddModelToJson(CartAddModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'cart': instance.cart,
      'success': instance.success,
    };

CartModelForAdd _$CartModelForAddFromJson(Map<String, dynamic> json) =>
    CartModelForAdd(
      user: json['user'] as String?,
      totalCartPriceAfterDiscount:
          (json['totalCartPriceAfterDiscount'] as num?)?.toDouble(),
      id: json['_id'] as String?,
      products:
          (json['products'] as List<dynamic>?)
              ?.map(
                (e) => CartAddProductModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      totalCartPrice: (json['totalCartPrice'] as num?)?.toDouble(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CartModelForAddToJson(CartModelForAdd instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'products': instance.products,
      'user': instance.user,
      'totalCartPrice': instance.totalCartPrice,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'totalCartPriceAfterDiscount': instance.totalCartPriceAfterDiscount,
    };

CartAddProductModel _$CartAddProductModelFromJson(Map<String, dynamic> json) =>
    CartAddProductModel(
      id: json['_id'] as String?,
      productId: json['productId'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartAddProductModelToJson(
  CartAddProductModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'productId': instance.productId,
  'quantity': instance.quantity,
  'price': instance.price,
};

CartUpdateModel _$CartUpdateModelFromJson(Map<String, dynamic> json) =>
    CartUpdateModel(
      message: json['message'] as String,
      cart: Cart.fromJson(json['cart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartUpdateModelToJson(CartUpdateModel instance) =>
    <String, dynamic>{'message': instance.message, 'cart': instance.cart};

AllLoggedCartModel _$AllLoggedCartModelFromJson(Map<String, dynamic> json) =>
    AllLoggedCartModel(
      message: json['message'] as String?,
      cart:
          json['cart'] == null
              ? null
              : Cart.fromJson(json['cart'] as Map<String, dynamic>),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AllLoggedCartModelToJson(AllLoggedCartModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'cart': instance.cart,
      'count': instance.count,
    };

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
  id: json['_id'] as String?,
  user: json['user'] as String?,
  products:
      (json['products'] as List<dynamic>?)
          ?.map((e) => CartGetProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  totalCartPrice: (json['totalCartPrice'] as num?)?.toDouble(),
  totalCartPriceAfterDiscount:
      (json['totalCartPriceAfterDiscount'] as num?)?.toDouble(),
  createdAt: Cart._fromJson(json['createdAt'] as String?),
  updatedAt: Cart._fromJson(json['updatedAt'] as String?),
);

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
  '_id': instance.id,
  'user': instance.user,
  'products': instance.products,
  'totalCartPrice': instance.totalCartPrice,
  'totalCartPriceAfterDiscount': instance.totalCartPriceAfterDiscount,
  'createdAt': Cart._toJson(instance.createdAt),
  'updatedAt': Cart._toJson(instance.updatedAt),
};

CartGetProductModel _$CartGetProductModelFromJson(Map<String, dynamic> json) =>
    CartGetProductModel(
      id: json['_id'] as String?,
      productId:
          json['productId'] == null
              ? null
              : Product.fromJson(json['productId'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartGetProductModelToJson(
  CartGetProductModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'productId': instance.productId,
  'quantity': instance.quantity,
  'price': instance.price,
};
