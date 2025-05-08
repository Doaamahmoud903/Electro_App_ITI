import 'package:electro/features/products/data/models/api_products_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'orders_model.g.dart';

@JsonSerializable()
class CreateOrder {
  final String? message;
  final OrderDetails? order;
  final bool? success;

  CreateOrder({this.message, this.order, this.success});

  factory CreateOrder.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderToJson(this);
}

@JsonSerializable()
class OrderDetailsForAdd {
  @JsonKey(name: "_id")
  final String? id;
  final String? user;
  final List<OrderItem>? orderItems;
  final double? totalOrderPrice;
  final ShoppingAddress? shoppingAddress;
  final String? paymentMethod;
  final bool? isPaid;
  final bool? isDelivered;
  final String? createdAt;
  final String? updatedAt;

  OrderDetailsForAdd({
    this.user,
    this.orderItems,
    this.totalOrderPrice,
    this.shoppingAddress,
    this.paymentMethod,
    this.isPaid,
    this.isDelivered,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderDetailsForAdd.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsForAddFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsForAddToJson(this);
}

@JsonSerializable()
class OrderItem {
  final String? productId;
  final int? quantity;
  final double? price;
  final String? id;

  OrderItem({this.productId, this.quantity, this.price, this.id});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

//   Get Orders Model
@JsonSerializable()
class GetOrderResponse {
  final String? message;
  final List<OrderDetails>? orders;
  final bool? success;

  GetOrderResponse({this.message, this.orders, this.success});

  factory GetOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrderResponseToJson(this);
}

@JsonSerializable()
class OrderDetails {
  @JsonKey(name: "_id")
  final String? id;
  final String? user;
  final List<OrderItems>? orderItems;
  final double? totalOrderPrice;
  final ShoppingAddress? shoppingAddress;
  final String? paymentMethod;
  final bool? isPaid;
  final bool? isDelivered;
  final String? createdAt;
  final String? updatedAt;

  OrderDetails({
    this.user,
    this.orderItems,
    this.totalOrderPrice,
    this.shoppingAddress,
    this.paymentMethod,
    this.isPaid,
    this.isDelivered,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsToJson(this);
}

@JsonSerializable()
class OrderItems {
  final ProductId? productId;
  final int? quantity;
  final double? price;
  final String? id;

  OrderItems({this.productId, this.quantity, this.price, this.id});

  factory OrderItems.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}

@JsonSerializable()
class ProductId {
  final ImageCover? imageCover;

  ProductId({this.imageCover});

  factory ProductId.fromJson(Map<String, dynamic> json) =>
      _$ProductIdFromJson(json);

  Map<String, dynamic> toJson() => _$ProductIdToJson(this);
}

@JsonSerializable()
class ShoppingAddress {
  final String? city;
  final String? street;
  final String? phone;

  ShoppingAddress({this.city, this.street, this.phone});

  factory ShoppingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShoppingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingAddressToJson(this);
}

@JsonSerializable()
class DeleteOrderResponse {
  final String? message;
  final bool? success;

  DeleteOrderResponse({this.message, this.success});

  factory DeleteOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteOrderResponseToJson(this);
}
