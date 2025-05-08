import 'package:electro/core/state_management/app_cubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppStates());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  Map<String, int> itemsCount = {};

  void increment(String productId) {
    itemsCount[productId] = (itemsCount[productId] ?? 0) + 1;
    emit(AppIncrementState());
  }

  void decrement(String productId) {
    if (itemsCount[productId] != null && itemsCount[productId]! > 0) {
      itemsCount[productId] = itemsCount[productId]! - 1;
      if (itemsCount[productId] == 0) {
        itemsCount.remove(productId);
        cartList.remove(productId);
      }
      emit(AppDecrementState());
    }
  }

  Map<String, Map<String, dynamic>> cartList = {};

  void addCartList({
    required String itemId,
    required Map<String, dynamic> value,
  }) {
    if (!cartList.containsKey(itemId)) {
      cartList[itemId] = value;
      emit(AddCartLisState());
    }
  }

  void removeCartList(String itemId) {
    if (cartList.containsKey(itemId)) {
      cartList.remove(itemId);
      emit(RemoveCartLisState());
    }
  }
}
