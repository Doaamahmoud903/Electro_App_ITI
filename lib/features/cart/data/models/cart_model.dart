import 'package:electro/features/wishlist/data/models/wishlist_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

// For add to cart response
@JsonSerializable()
class CartAddModel {
  final String? message;
  final CartModelForAdd? cart;
  final bool? success;

  CartAddModel({this.message, this.cart, this.success});

  factory CartAddModel.fromJson(Map<String, dynamic> json) =>
      _$CartAddModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartAddModelToJson(this);
}

@JsonSerializable()
class CartModelForAdd {
  @JsonKey(name: '_id')
  final String? id;
  final List<CartAddProductModel>? products;
  final String? user;
  final double? totalCartPrice;
  final String? createdAt;
  final String? updatedAt;
  final double? totalCartPriceAfterDiscount;

  CartModelForAdd({
    this.user,
    this.totalCartPriceAfterDiscount,
    this.id,
    this.products,
    this.totalCartPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory CartModelForAdd.fromJson(Map<String, dynamic> json) =>
      _$CartModelForAddFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelForAddToJson(this);
}

@JsonSerializable()
class CartAddProductModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? productId; // String for add operation
  final int? quantity;
  final double? price;

  CartAddProductModel({this.id, this.productId, this.quantity, this.price});

  factory CartAddProductModel.fromJson(Map<String, dynamic> json) =>
      _$CartAddProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartAddProductModelToJson(this);
}

// For get/update cart responses
@JsonSerializable()
class CartUpdateModel {
  final String message;
  final Cart cart;

  CartUpdateModel({required this.message, required this.cart});

  factory CartUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$CartUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartUpdateModelToJson(this);
}

@JsonSerializable()
class AllLoggedCartModel {
  final String? message;
  final Cart? cart;
  final int? count;

  AllLoggedCartModel({this.message, this.cart, this.count});

  factory AllLoggedCartModel.fromJson(Map<String, dynamic> json) =>
      _$AllLoggedCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllLoggedCartModelToJson(this);
}

@JsonSerializable()
class Cart {
  @JsonKey(name: '_id')
  final String? id;
  final String? user;
  final List<CartGetProductModel>? products;
  final double? totalCartPrice;
  final double? totalCartPriceAfterDiscount;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime? createdAt;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime? updatedAt;

  Cart({
    this.id,
    this.user,
    this.products,
    this.totalCartPrice,
    this.totalCartPriceAfterDiscount,
    this.createdAt,
    this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  static DateTime? _fromJson(String? date) =>
      date == null ? null : DateTime.parse(date);
  static String? _toJson(DateTime? date) => date?.toIso8601String();
}

@JsonSerializable()
class CartGetProductModel {
  @JsonKey(name: '_id')
  final String? id;
  final Product? productId;
  final int? quantity;
  final double? price;

  CartGetProductModel({this.id, this.productId, this.quantity, this.price});

  factory CartGetProductModel.fromJson(Map<String, dynamic> json) =>
      _$CartGetProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartGetProductModelToJson(this);
}
