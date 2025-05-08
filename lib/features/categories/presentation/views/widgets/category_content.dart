import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/custom_toast.dart';
import 'package:electro/features/categories/presentation/manager/categories_state.dart';
import 'package:electro/features/products/presentation/manager/products_cubit.dart';
import 'package:electro/features/products/presentation/manager/products_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/core/widgets/custom_cached_network_image.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class CategoryContent extends StatelessWidget {
  const CategoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsStates>(
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return const CustomLoadingItem();
        } else if (state is ProductsCategoryErrorState) {
          ToastUtils.showErrorToast(state.error);
        } else if (state is ProductsCategorySuccessState) {
          final products = state.categoryProductsModel.products ?? [];

          if (products.isEmpty) {
            return Center(child: Text(StringManager.no_products.tr(context)));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return InkWell(
                onTap: (){
                  context.pushNamed(
                    Routes.productDetailsScreen,
                    extra: product,
                  );
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomCachedNetworkImage(
                          url: product.imageCover!.secureUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.title!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
