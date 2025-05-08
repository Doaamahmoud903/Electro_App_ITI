import 'package:equatable/equatable.dart';
import 'package:electro/features/orders/data/models/orders_model.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class GetOrdersSuccess extends OrdersState {
  final GetOrderResponse orders;

  const GetOrdersSuccess(this.orders);

  @override
  List<Object?> get props => [orders];
}

class CreateOrderSuccess extends OrdersState {
  final CreateOrder order;

  const CreateOrderSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

class DeleteOrderSuccess extends OrdersState {
  final DeleteOrderResponse response;

  const DeleteOrderSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class OrdersFailure extends OrdersState {
  final String message;

  const OrdersFailure(this.message);

  @override
  List<Object?> get props => [message];
}
