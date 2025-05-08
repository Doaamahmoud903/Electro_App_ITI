import 'package:electro/core/functions/show_dialog_change_lang.dart';
import 'package:electro/core/functions/show_theme_dialog.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/features/account/presentation/views/widgets/logout_dialog.dart';
import 'package:electro/features/layout/presentation/views/widgets/search_ai_result_screen.dart';
import 'package:electro/features/products/presentation/manager/products_cubit.dart';
import 'package:electro/features/products/presentation/manager/products_states.dart';
import 'package:electro/features/profile/presentation/manager/user_cubit.dart';
import 'package:electro/features/profile/presentation/manager/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class AccountViewBody extends StatelessWidget {
  AccountViewBody({super.key});

  final TextEditingController _searchController = TextEditingController();

  void _onSearchSubmitted(BuildContext context) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      // Trigger the search by comparison
      context.read<ProductsCubit>().searchByComparison(query);

      // Listen for the result from the ProductsCubit
      context.read<ProductsCubit>().stream.listen((state) {
        if (state is SearchByComparisonSuccess) {
          // Navigate to SearchAiResultScreen and pass the comparison data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => SearchAiResultScreen(
                    comparisonResponse:
                        state.comparisonResponse, // Pass the data here
                  ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool themeCondition = context.read<ThemeCubit>().isLightMode;
    Color colorCondition =
        themeCondition ? ColorsManager.primaryLight : ColorsManager.primaryDark;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final userCubit = context.read<UserCubit>();
        String name = userCubit.name;
        String email = userCubit.email;

        if (state is GetUserSuccess) {
          name = state.userResponse.user!.name!;
          email = state.userResponse.user!.email!;
        }

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(12),
                          child: TextField(
                            style: TextStyle(
                              color:
                                  themeCondition
                                      ? ColorsManager.primaryDark
                                      : ColorsManager.whiteColor,
                              fontSize: 16,
                            ),
                            controller: _searchController,
                            onSubmitted: (_) => _onSearchSubmitted(context),
                            decoration: InputDecoration(
                              hintText: StringManager.compareProducts.tr(
                                context,
                              ),
                              hintStyle: TextStyle(
                                color: Theme.of(context).focusColor,
                                fontSize: 18,
                              ),
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor:
                                  themeCondition
                                      ? Colors.white
                                      : Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Profile Info
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: height * 0.015,
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(ImagesAssets.carousalImg1),
                      ),
                      title: Text(
                        name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      subtitle: Text(
                        email,
                        style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: 14,
                        ),
                      ),
                      trailing: InkWell(
                        onTap:
                            () => GoRouter.of(context).push(Routes.profileView),
                        child: Icon(
                          Icons.settings,
                          color:
                              themeCondition
                                  ? ColorsManager.primaryLight
                                  : ColorsManager.whiteColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Options
                  Container(
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: colorCondition,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        buildProfileOption(
                          EvaIcons.person_outline,
                          StringManager.profile.tr(context),
                          () {
                            GoRouter.of(context).push(Routes.profileView);
                          },
                        ),
                        buildProfileOption(
                          EvaIcons.shopping_bag_outline,
                          StringManager.orders.tr(context),
                          () {
                            GoRouter.of(context).push(Routes.orders);
                          },
                        ),
                        buildProfileOption(
                          EvaIcons.globe_outline,
                          StringManager.language.tr(context),
                          () {
                            showDialogChangeLang(context);
                          },
                        ),
                        buildProfileOption(
                          EvaIcons.color_palette_outline,
                          StringManager.theme.tr(context),
                          () {
                            showThemeDialog(context);
                          },
                        ),
                        buildProfileOption(
                          EvaIcons.lock_outline,
                          StringManager.changePassword.tr(context),
                          () {
                            GoRouter.of(
                              context,
                            ).push(Routes.changePasswordView);
                          },
                        ),
                        buildProfileOption(
                          EvaIcons.log_out_outline,
                          StringManager.logout.tr(context),
                          () {
                            showLogoutDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildProfileOption(IconData icon, String title, VoidCallback onTab) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: ColorsManager.whiteColor, fontSize: 16),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 18,
      ),
      onTap: onTab,
    );
  }
}
