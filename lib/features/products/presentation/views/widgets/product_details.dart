import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/functions/capitalize_text.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/custom_cached_network_image.dart';
import 'package:electro/features/products/data/models/api_products_model.dart';
import 'package:electro/features/wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/cart/presentation/manager/cart_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool themeCondition = context.read<ThemeCubit>().isDarkMode;
    final token = CacheHelper().getData("token");
    CartCubit.get(context).getCart(token);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorsManager.whiteColor),
          onPressed: () => context.pop(),
        ),
        foregroundColor: Colors.white,
        title: Text(
          CapitalizeText.capitalizeText(
            widget.product.title!
                .split(' ')
                .where((word) => word.isNotEmpty)
                .take(4)
                .join(" "),
          ),

          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color:
                themeCondition
                    ? ColorsManager.whiteColor
                    : ColorsManager.whiteColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorsManager.lightBlue, width: 2),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CustomCachedNetworkImage(
                        url: widget.product.imageCover!.secureUrl!,
                        height: height * 0.3,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          final token = CacheHelper().getData("token");
                          WishlistCubit.get(
                            context,
                          ).addToWishlsit(widget.product.id!, token);
                          ToastUtils.showSuccessToast(
                            StringManager.add_to_wishlist_success.tr(context),
                          );
                        },
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 1,
                      right: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color:
                              themeCondition
                                  ? ColorsManager.primaryDark
                                  : ColorsManager.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product!.title!
                                  .split(' ')
                                  .where((word) => word.isNotEmpty)
                                  .take(2)
                                  .map(
                                    (str) =>
                                        str[0].toUpperCase() +
                                        str.substring(1).toLowerCase(),
                                  )
                                  .join(' '),
                              style: theme.textTheme.headlineMedium,
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 4),
                                Text(
                                  '${StringManager.egy.tr(context)} ${widget.product.price}',
                                  style: theme.textTheme.headlineLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  CapitalizeText.capitalizeText(widget.product.brand!.name!),
                  style: theme.textTheme.headlineMedium,
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.product.rateAvg}',
                      style: theme.textTheme.headlineLarge,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color:
                        themeCondition
                            ? ColorsManager.primaryDark
                            : ColorsManager.primaryLight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed:
                            (widget.product.stock! > quantity)
                                ? () {
                                  setState(() {
                                    quantity++;
                                  });
                                  final token = CacheHelper().getData("token");
                                  CartCubit.get(context).updateQuantity(
                                    widget.product.id!,
                                    token,
                                    quantity,
                                  );
                                }
                                : null,
                        icon: ImageIcon(
                          const AssetImage(ImagesAssets.plusIcon),
                          color:
                              (widget.product.stock! > quantity)
                                  ? ColorsManager.lightBlue
                                  : ColorsManager.grey0,
                        ),
                      ),
                      Text(
                        "$quantity",
                        style: TextStyle(
                          color: ColorsManager.whiteColor,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed:
                            (quantity > 1 && widget.product.stock! > 0)
                                ? () {
                                  setState(() {
                                    quantity--;
                                  });
                                  final token = CacheHelper().getData("token");
                                  CartCubit.get(context).updateQuantity(
                                    widget.product.id!,
                                    token,
                                    quantity,
                                  );
                                }
                                : null,
                        icon: ImageIcon(
                          const AssetImage(ImagesAssets.minusIcon),
                          color:
                              (quantity > 1 && widget.product.stock! > 0)
                                  ? ColorsManager.lightBlue
                                  : ColorsManager.grey0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              StringManager.description.tr(context),
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),

            Text(
              widget.product.description!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      StringManager.totalPrice.tr(context),
                      style: theme.textTheme.headlineMedium,
                    ),
                    Text(
                      '${StringManager.egy.tr(context)} ${widget.product.price}',
                      style: theme.textTheme.headlineMedium,
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: width * 0.5,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor:
                          themeCondition
                              ? ColorsManager.lightBlue
                              : ColorsManager.primaryLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      final token = CacheHelper().getData("token");
                      CartCubit.get(
                        context,
                      ).addToCart(widget.product.id!, token);
                      ToastUtils.showSuccessToast(
                        StringManager.add_to_cart_success.tr(context),
                      );
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: ColorsManager.whiteColor,
                    ),
                    label: Text(
                      StringManager.addToCart.tr(context),
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorsManager.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: ColorsManager.yellowColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      context.push(
                        Routes.reviewsView,
                        extra: {"productId": widget.product.id, "token": token},
                      );
                    },
                    icon: Icon(
                      EvaIcons.star_outline,
                      color: ColorsManager.whiteColor,
                    ),
                    label: Text(
                      StringManager.rate_us.tr(context),
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorsManager.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
