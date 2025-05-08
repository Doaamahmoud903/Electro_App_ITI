import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/custom_confirm_dialog.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';
import 'package:electro/features/cart/presentation/manager/cart_cubit.dart';
import 'package:electro/features/cart/presentation/manager/cart_states.dart';
import 'package:electro/features/layout/presentation/views/widgets/app_navbar.dart';
import 'package:electro/features/wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:electro/features/wishlist/presentation/manager/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistViewBody extends StatelessWidget {
  const WishlistViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final token = CacheHelper().getData("token");
    WishlistCubit.get(context).getWishlist(token);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppNavbar(height: height, width: width),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state is CartAddSuccess) {
                ToastUtils.showSuccessToast(
                  StringManager.add_to_cart_success.tr(context),
                );
              } else if (state is CartFailure) {
                ToastUtils.showErrorToast(state.errorMessage);
              }
            },
          ),
          BlocListener<WishlistCubit, WishlistState>(
            listener: (context, state) {
              if (state is WishlistDeleteSuccess) {
                ToastUtils.showSuccessToast(
                  StringManager.remove_from_wishlist.tr(context),
                );
                WishlistCubit.get(context).getWishlist(token);
              } else if (state is WishlistClearSuccess) {
                ToastUtils.showSuccessToast(
                  StringManager.clr_wishlist_success.tr(context),
                );
                WishlistCubit.get(context).getWishlist(token);
              } else if (state is WishlistFailure) {
                ToastUtils.showErrorToast(state.errorMessage);
              }
            },
          ),
        ],
        child: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const CustomLoadingItem();
            } else if (state is WishlistLoaded) {
              final products = state.wishlist.wishlist?.products;
              if (products == null || products.isEmpty) {
                return Center(
                  child: Text(StringManager.no_favorites.tr(context)),
                );
              }

              return Column(
                children: [
                  // Clear Wishlist Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          showConfirmationDialog(
                            context: context,
                            title: StringManager.clr_wishlist.tr(context),
                            content: StringManager.clr_wishlist_ques.tr(
                              context,
                            ),
                            onConfirm: () {
                              WishlistCubit.get(context).clearWishlsit(token);
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
                          StringManager.clr_wishlist.tr(context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Wishlist Items
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        return Container(
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
                                child: Image.network(
                                  product.imageCover!.secureUrl!,
                                  width: 100,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: width * 0.03),

                              // Details Section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Name and Favorite Icon
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            product.title!,
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
                                            final productId = product.id;
                                            context
                                                .read<WishlistCubit>()
                                                .deleteFromWishlsit(
                                                  productId!,
                                                  token,
                                                );
                                          },
                                          icon: ImageIcon(
                                            const AssetImage(
                                              ImagesAssets.heartIcon,
                                            ),
                                            size: 35,
                                            color: ColorsManager.errorColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.01),

                                    // Category
                                    Text(
                                      product.category!,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.headlineSmall,
                                    ),
                                    SizedBox(height: height * 0.01),

                                    // Price and Add to Cart
                                    Row(
                                      children: [
                                        Text(
                                          product.price!.toString(),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineMedium?.copyWith(
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: ColorsManager.textColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                final productId = product.id;
                                                context
                                                    .read<CartCubit>()
                                                    .addToCart(
                                                      productId!,
                                                      token,
                                                    );
                                              },
                                              child: Text(
                                                StringManager.addToCart.tr(
                                                  context,
                                                ),
                                                style: TextStyle(
                                                  color:
                                                      ColorsManager.whiteColor,
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is WishlistFailure) {
              ToastUtils.showErrorToast(state.errorMessage);
            } else {
              return Center(child: Text(StringManager.errorOccur.tr(context)));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
