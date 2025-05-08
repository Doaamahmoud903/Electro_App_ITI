// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrder _$CreateOrderFromJson(Map<String, dynamic> json) => CreateOrder(
  message: json['message'] as String?,
  order:
      json['order'] == null
          ? null
          : OrderDetails.fromJson(json['order'] as Map<String, dynamic>),
  success: json['success'] as bool?,
);

Map<String, dynamic> _$CreateOrderToJson(CreateOrder instance) =>
    <String, dynamic>{
      'message': instance.message,
      'order': instance.order,
      'success': instance.success,
    };

OrderDetailsForAdd _$OrderDetailsForAddFromJson(Map<String, dynamic> json) =>
    OrderDetailsForAdd(
      user: json['user'] as String?,
      orderItems:
          (json['orderItems'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList(),
      totalOrderPrice: (json['totalOrderPrice'] as num?)?.toDouble(),
      shoppingAddress:
          json['shoppingAddress'] == null
              ? null
              : ShoppingAddress.fromJson(
                json['shoppingAddress'] as Map<String, dynamic>,
              ),
      paymentMethod: json['paymentMethod'] as String?,
      isPaid: json['isPaid'] as bool?,
      isDelivered: json['isDelivered'] as bool?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OrderDetailsForAddToJson(OrderDetailsForAdd instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'orderItems': instance.orderItems,
      'totalOrderPrice': instance.totalOrderPrice,
      'shoppingAddress': instance.shoppingAddress,
      'paymentMethod': instance.paymentMethod,
      'isPaid': instance.isPaid,
      'isDelivered': instance.isDelivered,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
  productId: json['productId'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
  id: json['id'] as String?,
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'productId': instance.productId,
  'quantity': instance.quantity,
  'price': instance.price,
  'id': instance.id,
};

GetOrderResponse _$GetOrderResponseFromJson(Map<String, dynamic> json) =>
    GetOrderResponse(
      message: json['message'] as String?,
      orders:
          (json['orders'] as List<dynamic>?)
              ?.map((e) => OrderDetails.fromJson(e as Map<String, dynamic>))
              .toList(),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$GetOrderResponseToJson(GetOrderResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'orders': instance.orders,
      'success': instance.success,
    };

OrderDetails _$OrderDetailsFromJson(Map<String, dynamic> json) => OrderDetails(
  user: json['user'] as String?,
  orderItems:
      (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItems.fromJson(e as Map<String, dynamic>))
          .toList(),
  totalOrderPrice: (json['totalOrderPrice'] as num?)?.toDouble(),
  shoppingAddress:
      json['shoppingAddress'] == null
          ? null
          : ShoppingAddress.fromJson(
            json['shoppingAddress'] as Map<String, dynamic>,
          ),
  paymentMethod: json['paymentMethod'] as String?,
  isPaid: json['isPaid'] as bool?,
  isDelivered: json['isDelivered'] as bool?,
  id: json['_id'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$OrderDetailsToJson(OrderDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'orderItems': instance.orderItems,
      'totalOrderPrice': instance.totalOrderPrice,
      'shoppingAddress': instance.shoppingAddress,
      'paymentMethod': instance.paymentMethod,
      'isPaid': instance.isPaid,
      'isDelivered': instance.isDelivered,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

OrderItems _$OrderItemsFromJson(Map<String, dynamic> json) => OrderItems(
  productId:
      json['productId'] == null
          ? null
          : ProductId.fromJson(json['productId'] as Map<String, dynamic>),
  quantity: (json['quantity'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
  id: json['id'] as String?,
);

Map<String, dynamic> _$OrderItemsToJson(OrderItems instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'price': instance.price,
      'id': instance.id,
    };

ProductId _$ProductIdFromJson(Map<String, dynamic> json) => ProductId(
  imageCover:
      json['imageCover'] == null
          ? null
          : ImageCover.fromJson(json['imageCover'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductIdToJson(ProductId instance) => <String, dynamic>{
  'imageCover': instance.imageCover,
};

ShoppingAddress _$ShoppingAddressFromJson(Map<String, dynamic> json) =>
    ShoppingAddress(
      city: json['city'] as String?,
      street: json['street'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ShoppingAddressToJson(ShoppingAddress instance) =>
    <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'phone': instance.phone,
    };

DeleteOrderResponse _$DeleteOrderResponseFromJson(Map<String, dynamic> json) =>
    DeleteOrderResponse(
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$DeleteOrderResponseToJson(
  DeleteOrderResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'success': instance.success,
};
