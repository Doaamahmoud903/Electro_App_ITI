import 'dart:math';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';
import 'package:electro/features/categories/presentation/manager/categories_cubit.dart';
import 'package:electro/features/categories/presentation/manager/categories_state.dart';
import 'package:electro/features/categories/presentation/views/widgets/category_item.dart';
import 'package:electro/features/home/presentation/views/widgets/home_carosuel.dart';
import 'package:electro/features/home/presentation/views/widgets/home_carosuel_item.dart';
import 'package:electro/features/layout/presentation/views/widgets/app_navbar.dart';
import 'package:electro/features/products/presentation/manager/products_cubit.dart';
import 'package:electro/features/products/presentation/manager/products_states.dart';
import 'package:electro/features/products/presentation/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/layout/presentation/manager/layout_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppNavbar(width: width, height: height, removePadding: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            child: Column(
              children: [
                const HomeCarosuel(
                  items: [
                    HomeCarousalItem(
                      img: ImagesAssets.carousalImg2,
                      right: 0,
                      left: 40,
                    ),
                    HomeCarousalItem(
                      img: ImagesAssets.carousalImg1,
                      right: 40,
                      left: 0,
                    ),
                    HomeCarousalItem(
                      img: ImagesAssets.carousalImg3,
                      right: 0,
                      left: 40,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringManager.categories.tr(context),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          LayoutCubit.get(context).goToCategoriesView();
                        },
                        child: Text(
                          StringManager.view_all.tr(context),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01),
                BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoadingState) {
                      return const CustomLoadingItem();
                    } else if (state is CategoriesErrorState) {
                      return Text(StringManager.error.tr(context));
                    } else if (state is CategoriesSuccessState) {
                      final categories =
                          state.categoriesResponse.categories ?? [];
                      if (categories.isEmpty) {
                        return Text(StringManager.no_categories.tr(context));
                      }
                      return SizedBox(
                        height: height * 0.24,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: 1,
                              ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: min(categories.length, 12),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return CategoryItem(
                              title: category.name!,
                              image: category.image!.secureUrl!,
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringManager.feature_products.tr(context),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          LayoutCubit.get(context).goToProductsView();
                        },
                        child: Text(
                          StringManager.view_all.tr(context),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01),
                BlocBuilder<ProductsCubit, ProductsStates>(
                  builder: (context, state) {
                    if (state is ProductsLoadingState) {
                      return const CustomLoadingItem();
                    } else if (state is ProductsErrorState) {
                      return Text(StringManager.error.tr(context));
                    } else if (state is ProductsSuccessState) {
                      final products = state.productsResponse!.products!;
                      if (products.isEmpty) {
                        return Text(StringManager.no_products.tr(context));
                      }
                      return SizedBox(
                        height: height * 0.35,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.75,
                              ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: min(products.length, 8),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return InkWell(
                              onTap: (){
                                context.pushNamed(
                                  Routes.productDetailsScreen,
                                  extra: product,
                                );
                              },
                              child: ProductItem(
                                title: product.title!,
                                image: product.imageCover!.secureUrl!,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
