import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/widgets/app_logo.dart';
import 'package:electro/features/layout/presentation/views/widgets/app_bar_search.dart';
import 'package:electro/features/layout/presentation/views/widgets/search_results_screen.dart';
import 'package:electro/features/products/presentation/manager/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final double width;
  final bool showCartIcon;
  final bool removePadding;
  final bool showIconBack;

  AppNavbar({
    super.key,
    required this.width,
    required this.height,
    this.showCartIcon = true,
    this.removePadding = false,
    this.showIconBack = false,
  });

  final TextEditingController _searchController = TextEditingController();
  void _onSearchSubmitted(BuildContext context) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<ProductsCubit>().searchProducts(query);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SearchResultsScreen()),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    //bool themeCondition = context.read<ThemeCubit>().isLightMode;
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      // automaticallyImplyLeading: false,
      toolbarHeight: 220,
      automaticallyImplyLeading: showIconBack,

      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: removePadding ? 0 : width * 0.01,
          vertical: height * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            const Row(children: [AppLogo()]),
            // Search Bar + Cart
            Row(
              children: [
                AppBarSearch(
                  onSearchSubmitted: () => _onSearchSubmitted(context),
                  searchController: _searchController,
                ),
                const SizedBox(width: 16),
                if (showCartIcon)
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).push(Routes.cart);
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsManager.primaryLight,
                      ),
                      child: Center(
                        child: ImageIcon(
                          const AssetImage(ImagesAssets.cartIcon),
                          color: ColorsManager.whiteColor,
                          size: 25,
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
