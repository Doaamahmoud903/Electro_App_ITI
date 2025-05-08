import 'package:electro/features/cart/data/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final AllLoggedCartModel cart;
  CartLoaded(this.cart);
}

class CartAddSuccess extends CartState {
  final CartAddModel cartModel;
  CartAddSuccess(this.cartModel);
}

class CartUpdateSuccess extends CartState {
  final CartUpdateModel updatedCart;
  CartUpdateSuccess(this.updatedCart);
}

class CartDeleteSuccess extends CartState {
  final CartUpdateModel deletedItem;
  CartDeleteSuccess(this.deletedItem);
}

class CartClearSuccess extends CartState {
  final CartAddModel clearedCart;
  CartClearSuccess(this.clearedCart);
}

class CartFailure extends CartState {
  final String errorMessage;
  CartFailure(this.errorMessage);
}
