import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/functions/capitalize_text.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';
import 'package:electro/core/widgets/custom_toast.dart';
import 'package:electro/core/widgets/show_default_dialod.dart';
import 'package:electro/features/cart/presentation/manager/cart_cubit.dart';
import 'package:electro/features/cart/presentation/manager/cart_states.dart';
import 'package:electro/features/layout/presentation/views/widgets/app_navbar.dart';
import 'package:electro/features/products/presentation/manager/products_cubit.dart';
import 'package:electro/features/products/presentation/manager/products_states.dart';
import 'package:electro/features/products/presentation/views/widgets/product_card.dart';
import 'package:electro/features/wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:electro/features/wishlist/presentation/manager/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:number_pagination/number_pagination.dart';

class ProductsViewBody extends StatefulWidget {
  const ProductsViewBody({super.key});

  @override
  State<ProductsViewBody> createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {
  int selectedPageNumber = 1;
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProductsByPage(page: selectedPageNumber);
  }

  void _onPageChanged(int pageNumber) {
    setState(() {
      selectedPageNumber = pageNumber;
    });
    context.read<ProductsCubit>().getProductsByPage(page: pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool themeCondition = context.read<ThemeCubit>().isLightMode;

    return Scaffold(
      appBar: AppNavbar(width: width, height: height, removePadding: true),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state is CartAddSuccess) {
                ToastUtils.showSuccessToast(
                  StringManager.add_to_cart_success.tr(context),
                );
              } else if (state is CartFailure) {
                ToastUtils.showSuccessToast(state.errorMessage);
              }
            },
          ),
          BlocListener<WishlistCubit, WishlistState>(
            listener: (context, state) {
              if (state is WishlistAddSuccess) {
                ToastUtils.showSuccessToast(
                  StringManager.add_to_wishlist_success.tr(context),
                );
              } else if (state is WishlistDeleteSuccess) {
                ToastUtils.showSuccessToast(
                  StringManager.remove_from_wishlist.tr(context),
                );
              } else if (state is WishlistFailure) {
                ToastUtils.showErrorToast(state.errorMessage);
              }
            },
          ),
        ],
        child: BlocConsumer<ProductsCubit, ProductsStates>(
          listener: (context, state) {
            if (state is ProductsErrorState) {
              ToastUtils.showErrorToast(state.error);
            }
          },
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const CustomLoadingItem();
            } else if (state is ProductsSuccessState) {
              final products = state.productsResponse.products ?? [];
              final int totalProducts =
                  state.productsResponse.totalProducts ?? 0;
              const int itemsPerPage = 10;
              final int totalPages = (totalProducts / itemsPerPage).ceil();

              return Column(
                children: [
                  Expanded(
                    child:
                        products.isEmpty
                            ? Center(
                              child: Text(
                                StringManager.no_products.tr(context),
                              ),
                            )
                            : GridView.builder(
                              padding: EdgeInsets.all(width * 0.04),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.55,
                                    crossAxisSpacing: width * 0.04,
                                    mainAxisSpacing: height * 0.02,
                                  ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.productDetailsScreen,
                                      extra: product,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 2,
                                        color: ColorsManager.primaryLight,
                                      ),
                                    ),
                                    child: ProductCard(
                                      onPressedCart: () {
                                        final productId = product.id;
                                        final token = CacheHelper().getData(
                                          "token",
                                        );
                                        context.read<CartCubit>().addToCart(
                                          productId!,
                                          token,
                                        );
                                      },
                                      onPressedWishlist: () {
                                        final productId = product.id;
                                        final token = CacheHelper().getData(
                                          "token",
                                        );
                                        context
                                            .read<WishlistCubit>()
                                            .addToWishlsit(productId!, token);
                                      },
                                      imageUrl:
                                          product.imageCover?.secureUrl ?? "",
                                      title: (CapitalizeText.capitalizeText(
                                                product.title!,
                                              ) ??
                                              "")
                                          .split(' ')
                                          .take(5)
                                          .join(' '),
                                      desc: (product.description ?? '')
                                          .split(' ')
                                          .take(5)
                                          .join(' '),
                                      priceAfterDiscount:
                                          product.priceAfterDiscount
                                              ?.toStringAsFixed(2) ??
                                          "",
                                      price:
                                          product.price?.toStringAsFixed(2) ??
                                          "",
                                      rate: product.rateAvg.toString() ?? "",
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),
                  const SizedBox(height: 16),
                  NumberPagination(
                    selectedButtonColor: ColorsManager.lightBlue,
                    unSelectedButtonColor:
                        themeCondition
                            ? ColorsManager.primaryDark
                            : ColorsManager.whiteColor,

                    onPageChanged: _onPageChanged,
                    visiblePagesCount: 5,
                    totalPages: totalPages,
                    currentPage: selectedPageNumber,
                  ),

                  const SizedBox(height: 16),
                ],
              );
            }

            return Center(child: Text(StringManager.errorOccur.tr(context)));
          },
        ),
      ),
    );
  }
}
