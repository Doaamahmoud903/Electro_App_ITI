import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String priceAfterDiscount;
  final String price;
  final String rate;
  final Function()? onPressedWishlist;
  final Function()? onPressedCart;
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.priceAfterDiscount,
    required this.price,
    required this.rate,
    this.onPressedWishlist,
    this.onPressedCart,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool themeCondition = context.read<ThemeCubit>().isLightMode;

    return Card(
      elevation: 0,
      color:
          themeCondition ? ColorsManager.whiteColor : ColorsManager.primaryDark,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height * 0.12,
                  width: double.infinity,
                  color:
                      themeCondition
                          ? ColorsManager.whiteColor
                          : ColorsManager.primaryDark,
                  child: Image(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Material(
                    elevation: 3.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: ColorsManager.whiteColor,
                      child: IconButton(
                        onPressed: onPressedWishlist,
                        icon: ImageIcon(
                          const AssetImage(ImagesAssets.heartIconCircle),
                          size: 30,
                          color: ColorsManager.primaryDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Text(
              title,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * 0.01),
            Text(
              desc,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color:
                    themeCondition
                        ? ColorsManager.arrowListTile
                        : ColorsManager.lightPrimary,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * 0.01),
            Row(
              children: [
                Text(
                  priceAfterDiscount,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color:
                        themeCondition
                            ? ColorsManager.arrowListTile
                            : ColorsManager.lightPrimary,
                  ),
                ),
                SizedBox(width: width * 0.03),
                Text(
                  price,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: ColorsManager.lightBlue,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Row(
              children: [
                Text(
                  StringManager.reviews.tr(context),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color:
                        themeCondition
                            ? ColorsManager.arrowListTile
                            : ColorsManager.lightPrimary,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: width * 0.01),
                Text(
                  '($rate)',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color:
                        themeCondition
                            ? ColorsManager.arrowListTile
                            : ColorsManager.lightPrimary,
                    fontSize: 12,
                  ),
                ),
                Image.asset(
                  ImagesAssets.starIcon,
                  height: height * 0.02,
                  width: width * 0.05,
                ),
                const Spacer(),
                IconButton(
                  onPressed: onPressedCart,
                  icon: ImageIcon(
                    const AssetImage(ImagesAssets.plusIconCircle),
                    color:
                        themeCondition
                            ? ColorsManager.arrowListTile
                            : ColorsManager.lightBlue,
                    size: 30,
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
