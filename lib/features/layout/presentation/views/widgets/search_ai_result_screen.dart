import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/functions/capitalize_text.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/custom_cached_network_image.dart';
import 'package:electro/features/cart/presentation/manager/cart_cubit.dart';
import 'package:electro/features/cart/presentation/manager/cart_states.dart';
import 'package:electro/features/products/data/models/ai_comparison_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchAiResultScreen extends StatelessWidget {
  final ComparisonResponse comparisonResponse; // Accept ComparisonResponse

  const SearchAiResultScreen({super.key, required this.comparisonResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.compareProducts.tr(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.32,
          ),
          itemCount: comparisonResponse.comparison.length,
          itemBuilder: (context, index) {
            final comparisonItem = comparisonResponse.comparison[index];
            return ComparisonItemCard(item: comparisonItem);
          },
        ),
      ),
    );
  }
}

class ComparisonItemCard extends StatelessWidget {
  final ComparisonItem item;

  const ComparisonItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    bool themeCondition = context.read<ThemeCubit>().isLightMode;
    var height = MediaQuery.of(context).size.height;
    final token = CacheHelper().getData("token");
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartAddSuccess) {
          ToastUtils.showSuccessToast(
            StringManager.add_to_cart_success.tr(context),
          );
        } else if (state is CartFailure) {
          ToastUtils.showSuccessToast(state.errorMessage);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.02),
          child: Card(
            color:
                themeCondition
                    ? ColorsManager.primaryLight
                    : ColorsManager.primaryDark,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomCachedNetworkImage(
                    url: item.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.09,
                        child: Text(
                          CapitalizeText.capitalizeText(item.name),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        item.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        '${StringManager.price.tr(context)} \$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        '${StringManager.brand.tr(context)}: ${item.brand}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        '${StringManager.category.tr(context)}: ${item.category}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<CartCubit>().addToCart(
                                item.id!,
                                token,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              StringManager.addToCart.tr(context),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
