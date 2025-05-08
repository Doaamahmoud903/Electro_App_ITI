import 'package:bloc/bloc.dart';
import 'package:electro/features/cart/data/models/cart_model.dart';
import 'package:electro/features/cart/data/repos/cart_repo.dart';
import 'package:electro/features/cart/presentation/manager/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;
  CartCubit(this.cartRepo) : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);

  Future<void> getCart(String token) async {
    emit(CartLoading());
    final response = await cartRepo.getLoggedCart(token: token);
    print(response);

    response.fold(
      (failure) => emit(CartFailure(failure.errMessage)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  Future<void> addToCart(String productId, String token) async {
    emit(CartLoading());
    final response = await cartRepo.addToCart(
      productId: productId,
      token: token,
    );
    print(response);

    response.fold(
      (failure) => emit(CartFailure(failure.errMessage)),
      (addedCart) => emit(CartAddSuccess(addedCart)),
    );
  }

  Future<void> updateQuantity(
    String productId,
    String token,
    int quantity,
  ) async {
    emit(CartLoading());
    final response = await cartRepo.updateQuantity(
      productId: productId,
      token: token,
      quantity: quantity,
    );
    print(response);

    response.fold((failure) => emit(CartFailure(failure.errMessage)), (
      updatedCart,
    ) {
      getCart(token);
      emit(CartUpdateSuccess(updatedCart));
    });
  }

  Future<void> deleteFromCart(String productId, String token) async {
    emit(CartLoading());
    final response = await cartRepo.deleteFromCart(
      productId: productId,
      token: token,
    );

    response.fold((failure) => emit(CartFailure(failure.errMessage)), (
      deletedItem,
    ) async {
      emit(CartDeleteSuccess(deletedItem));

      // Fetch the updated cart after deletion
      final cartResponse = await cartRepo.getLoggedCart(token: token);

      cartResponse.fold(
        (failure) => emit(CartFailure(failure.errMessage)),
        (cartData) => emit(CartLoaded(cartData)),
      );
    });
  }

  Future<void> clearCart(String token) async {
    emit(CartLoading());
    final response = await cartRepo.clearCart(token: token);
    print(response);

    response.fold((failure) => emit(CartFailure(failure.errMessage)), (
      clearedCart,
    ) {
      getCart(token);
      emit(CartClearSuccess(clearedCart));
    });
  }
}
