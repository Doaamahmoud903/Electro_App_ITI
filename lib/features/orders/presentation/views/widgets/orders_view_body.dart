import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/styles_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';
import 'package:electro/features/layout/presentation/views/widgets/app_navbar.dart';
import 'package:electro/features/orders/presentation/manager/orders_cubit.dart';
import 'package:electro/features/orders/presentation/manager/orders_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final token = CacheHelper().getData("token");
    final bool isLightMode = context.read<ThemeCubit>().isLightMode;
    final Color colorCondition =
        isLightMode ? ColorsManager.primaryDark : ColorsManager.whiteColor;

    return Scaffold(
      appBar: AppNavbar(
        width: width,
        height: height,
        removePadding: true,
        showIconBack: true,
      ),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is DeleteOrderSuccess) {
            ToastUtils.showSuccessToast(StringManager.cancelOrder.tr(context));
          } else if (state is OrdersFailure) {
            ToastUtils.showErrorToast(state.message);
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const CustomLoadingItem();
          } else if (state is GetOrdersSuccess) {
            final orders = state.orders.orders;
            if (orders == null || orders.isEmpty) {
              return Center(child: Text(StringManager.no_orders.tr(context)));
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  color:
                      isLightMode
                          ? ColorsManager.primaryLight
                          : ColorsManager.primaryDark,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 80,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: order.orderItems!.length,
                            separatorBuilder:
                                (context, index) => const SizedBox(width: 8),
                            itemBuilder: (context, i) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  order
                                      .orderItems![i]
                                      .productId!
                                      .imageCover!
                                      .secureUrl!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          title: Text(
                            '${StringManager.orderId.tr(context)}: ${order.id}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: ColorsManager.whiteColor,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.01),
                              Text(
                                '${StringManager.status.tr(context)}: ${order.isDelivered! ? StringManager.delivered.tr(context) : StringManager.notDelivered.tr(context)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ColorsManager.grey1,
                                ),
                              ),
                              Text(
                                '${StringManager.totalPrice.tr(context)}: ${StringManager.egy.tr(context)} ${order.totalOrderPrice}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ColorsManager.grey1,
                                ),
                              ),
                            ],
                          ),
                          trailing: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: ColorsManager.errorColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              StringManager.cancel.tr(context),
                              style: TextStyle(
                                color: ColorsManager.whiteColor,
                                fontSize: Styles.textStyle16w7.fontSize,
                              ),
                            ),
                          ),
                          onTap: () {
                            context.read<OrdersCubit>().deleteOrder(
                              token: token,
                              orderId: order.id!,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                StringManager.pressBtn.tr(context),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (token != null) {
            context.read<OrdersCubit>().getOrders(token: token);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User token not found.')),
            );
          }
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
