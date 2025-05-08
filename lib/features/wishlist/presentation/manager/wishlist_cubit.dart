import 'package:electro/features/wishlist/data/repos/wishlist_repo.dart';
import 'package:electro/features/wishlist/presentation/manager/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepo wishlistRepo;
  WishlistCubit(this.wishlistRepo) : super(WishlistInitial());
  static WishlistCubit get(context) => BlocProvider.of<WishlistCubit>(context);

  Future<void> getWishlist(String token) async {
    emit(WishlistLoading());
    final response = await wishlistRepo.getLoggedWishlsit(token: token);
    print(response);

    response.fold(
      (failure) => emit(WishlistFailure(failure.errMessage)),
      (wishlist) => emit(WishlistLoaded(wishlist)),
    );
  }

  Future<void> addToWishlsit(String productId, String token) async {
    emit(WishlistLoading());
    final response = await wishlistRepo.addToWishlsit(
      productId: productId,
      token: token,
    );
    print(response);

    response.fold(
      (failure) => emit(WishlistFailure(failure.errMessage)),
      (addedWishlist) => emit(WishlistAddSuccess(addedWishlist)),
    );
  }

  Future<void> deleteFromWishlsit(String productId, String token) async {
    emit(WishlistLoading());
    final response = await wishlistRepo.deleteFromWishlsit(
      productId: productId,
      token: token,
    );
    print(response);

    response.fold(
      (failure) => emit(WishlistFailure(failure.errMessage)),
      (deletedItem) => emit(WishlistDeleteSuccess(deletedItem)),
    );
  }

  Future<void> clearWishlsit(String token) async {
    emit(WishlistLoading());
    final response = await wishlistRepo.clearWishlsit(token: token);
    print(response);

    response.fold(
      (failure) => emit(WishlistFailure(failure.errMessage)),
      (clearedWishlist) => emit(WishlistClearSuccess(clearedWishlist)),
    );
  }
}
