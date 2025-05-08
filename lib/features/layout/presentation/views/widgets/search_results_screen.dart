import 'package:electro/core/functions/capitalize_text.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/widgets/custom_cached_network_image.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';
import 'package:electro/features/layout/presentation/views/widgets/app_navbar.dart';
import 'package:electro/features/products/data/models/api_products_model.dart';
import 'package:electro/features/products/presentation/manager/products_cubit.dart';
import 'package:electro/features/products/presentation/manager/products_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool themeCondition = context.read<ThemeCubit>().isDarkMode;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppNavbar(
        width: width,
        height: height,
        showCartIcon: false,
        removePadding: true,
        showIconBack: true,
      ),
      body: BlocBuilder<ProductsCubit, ProductsStates>(
        builder: (context, state) {
          if (state is ProductsLoadingState) {
            return const Center(child: CustomLoadingItem());
          } else if (state is ProductsErrorState) {
            return Center(child: Text(state.error));
          } else if (state is ProductsSuccessState) {
            final products = state.productsResponse.products;

            if (state is ProductsEmpty) {
              return Center(child: Text(StringManager.no_products.tr(context)));
            }

            return _buildProductList(products!, themeCondition);
          }

          // Default fallback: initial or unknown state
          return Center(child: Text(StringManager.no_products.tr(context)));
        },
      ),
    );
  }

  Widget _buildProductList(List<Product> products, bool themeCondition) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          leading: CustomCachedNetworkImage(
            url: product.imageCover!.secureUrl!,
            fit: BoxFit.contain,
          ),
          title: Text(
            CapitalizeText.capitalizeText(product.title!),
            style: TextStyle(
              color:
                  themeCondition
                      ? ColorsManager.whiteColor
                      : ColorsManager.primaryDark,
            ),
          ),
          subtitle: Text(
            '${StringManager.egy.tr(context)} ${product.price}',
            style: TextStyle(
              color:
                  themeCondition
                      ? ColorsManager.whiteColor
                      : ColorsManager.primaryDark,
            ),
          ),
          onTap: () {
            context.pushNamed(Routes.productDetailsScreen, extra: product);
          },
        );
      },
    );
  }
}
