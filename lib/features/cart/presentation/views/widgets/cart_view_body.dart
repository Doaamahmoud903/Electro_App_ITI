import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/custom_confirm_dialog.dart';
import 'package:electro/features/cart/presentation/manager/cart_cubit.dart';
import 'package:electro/features/cart/presentation/manager/cart_states.dart';
import 'package:electro/features/layout/presentation/views/widgets/second_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:electro/features/layout/presentation/manager/layout_cubit.dart';
import 'package:electro/core/widgets/custom_cached_network_image.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final token = CacheHelper().getData("token");
    CartCubit.get(context).getCart(token);
    bool themeCondition = context.read<ThemeCubit>().isDarkMode;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: SecondAppbar(name: StringManager.cart.tr(context)),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartAddSuccess) {
            ToastUtils.showSuccessToast(
              StringManager.add_to_cart_success.tr(context),
            );
          } else if (state is CartFailure) {
            ToastUtils.showErrorToast(state.errorMessage);
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const CustomLoadingItem();
            } else if (state is CartLoaded) {
              final products = state.cart.cart!.products!;
              // final count = state.cart.count;

              if (products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 80,
                        color: ColorsManager.primaryLight,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        StringManager.cart_empty.tr(context),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primaryLight,
                        ),
                        onPressed: () {
                          // Navigate to home or product listing
                          // context.pushReplacement(Routes.productsView);
                          LayoutCubit.get(context).changeBottom(1);
                          context.pushReplacement(Routes.layout);
                        },
                        child: Text(
                          StringManager.browseProducts.tr(context),
                          style: TextStyle(
                            color: ColorsManager.whiteColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  // Clear Cart Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            showConfirmationDialog(
                              context: context,
                              title: StringManager.clr_cart.tr(context),
                              content: StringManager.clr_cart_ques.tr(context),
                              onConfirm: () {
                                CartCubit.get(context).clearCart(token);
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.errorColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                          child: Text(
                            StringManager.clr_cart.tr(context),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            context.push(
                              Routes.addOrders,
                              extra: {
                                'token': token,
                                'cartId': state.cart.cart!.id,
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                          child: Text(
                            StringManager.addOrder.tr(context),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Cart Items
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        final quantity = product.quantity;
                        final stock = product.productId!.stock;
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            key: ValueKey(product.productId!.id),
                            margin: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.01,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2,
                                color: ColorsManager.primary,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Image Section
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CustomCachedNetworkImage(
                                    url:
                                        product
                                            .productId!
                                            .imageCover!
                                            .secureUrl!,
                                  ),
                                ),
                                SizedBox(width: width * 0.03),

                                // Details Section
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Name and Favorite Icon
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              product.productId!.title!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              final productId =
                                                  product.productId!.id!;
                                              context
                                                  .read<CartCubit>()
                                                  .deleteFromCart(
                                                    productId!,
                                                    token,
                                                  );
                                            },
                                            icon: ImageIcon(
                                              const AssetImage(
                                                ImagesAssets.deleteIcon,
                                              ),
                                              size: 35,
                                              color: ColorsManager.errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.01),

                                      // Price and Add to Cart
                                      Row(
                                        children: [
                                          Text(
                                            product.price!.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                  color: ColorsManager.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Container(
                                            height: 1,
                                            width: 20,
                                            color: ColorsManager.primary,
                                          ),
                                          SizedBox(height: height * 0.02),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  onPressed:
                                                      (stock! > quantity!)
                                                          ? () {
                                                            final productId =
                                                                product
                                                                    .productId!
                                                                    .id!;
                                                            CartCubit.get(
                                                              context,
                                                            ).updateQuantity(
                                                              productId,
                                                              token,
                                                              quantity! + 1,
                                                            );
                                                          }
                                                          : null,
                                                  icon: ImageIcon(
                                                    const AssetImage(
                                                      ImagesAssets.plusIcon,
                                                    ),
                                                    size: 35,
                                                    color:
                                                        (stock! > quantity!)
                                                            ? ColorsManager
                                                                .primary
                                                            : ColorsManager
                                                                .grey0,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.03,
                                                    vertical: height * 0.01,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorsManager.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    quantity.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed:
                                                      (stock! > 0 &&
                                                              quantity! > 1)
                                                          ? () {
                                                            final productId =
                                                                product
                                                                    .productId!
                                                                    .id!;
                                                            CartCubit.get(
                                                              context,
                                                            ).updateQuantity(
                                                              productId,
                                                              token,
                                                              quantity! - 1,
                                                            );
                                                          }
                                                          : null,
                                                  icon: ImageIcon(
                                                    const AssetImage(
                                                      ImagesAssets.minusIcon,
                                                    ),
                                                    size: 35,
                                                    color:
                                                        (stock! > 0 &&
                                                                quantity! > 1)
                                                            ? ColorsManager
                                                                .primary
                                                            : ColorsManager
                                                                .grey0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is CartFailure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else if (state is CartClearSuccess) {
              ToastUtils.showSuccessToast(
                StringManager.clr_cart_success.tr(context),
              );
            }
            return const CustomLoadingItem();
          },
        ),
      ),
    );
  }
}
