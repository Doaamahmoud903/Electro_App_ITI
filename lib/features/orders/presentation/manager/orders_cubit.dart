import 'package:electro/features/orders/presentation/manager/orders_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/orders/data/repos/orders_repo.dart';
import 'package:electro/features/orders/data/models/orders_model.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo ordersRepo;

  OrdersCubit(this.ordersRepo) : super(OrdersInitial());

  Future<void> getOrders({required String token}) async {
    emit(OrdersLoading());
    final result = await ordersRepo.getOrders(token: token);
    result.fold(
      (failure) => emit(OrdersFailure(failure.errMessage)),
      (orders) => emit(GetOrdersSuccess(orders)),
    );
  }

  Future<void> createOrder({
    required String token,
    required String cartId,
    required ShoppingAddress shoppingAddress,
  }) async {
    emit(OrdersLoading());
    final result = await ordersRepo.createOrders(
      token: token,
      cartId: cartId,
      shoppingAddress: shoppingAddress,
    );
    result.fold(
      (failure) => emit(OrdersFailure(failure.errMessage)),
      (order) => emit(CreateOrderSuccess(order)),
    );
  }

  Future<void> deleteOrder({
    required String token,
    required String orderId,
  }) async {
    emit(OrdersLoading());
    final result = await ordersRepo.deleteOrder(token: token, orderId: orderId);
    result.fold(
      (failure) => emit(OrdersFailure(failure.errMessage)),
      (response) => emit(DeleteOrderSuccess(response)),
    );
  }
}
