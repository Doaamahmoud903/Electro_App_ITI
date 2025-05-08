import 'package:electro/features/wishlist/data/models/wishlist_model.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final WishlistGetModel wishlist;
  WishlistLoaded(this.wishlist);
}

class WishlistAddSuccess extends WishlistState {
  final WishlistAddModel wishlistModel;
  WishlistAddSuccess(this.wishlistModel);
}

class WishlistDeleteSuccess extends WishlistState {
  final WishlistAddModel deletedItem;
  WishlistDeleteSuccess(this.deletedItem);
}

class WishlistClearSuccess extends WishlistState {
  final WishlistAddModel clearedWishlist;
  WishlistClearSuccess(this.clearedWishlist);
}

class WishlistFailure extends WishlistState {
  final String errorMessage;
  WishlistFailure(this.errorMessage);
}
