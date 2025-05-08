import 'package:electro/core/functions/capitalize_text.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/core/utils/toast_utils.dart';
import 'package:electro/core/widgets/show_default_dialod.dart';
import 'package:electro/features/categories/presentation/manager/categories_cubit.dart';
import 'package:electro/features/categories/presentation/manager/categories_state.dart';
import 'package:electro/features/categories/presentation/views/widgets/category_selection_cubit.dart';
import 'package:electro/features/categories/presentation/views/widgets/selected_category.dart';
import 'package:electro/features/products/presentation/manager/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/core/widgets/custom_loading_item.dart';

class CategorySidebar extends StatelessWidget {
  const CategorySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesErrorState) {
            ToastUtils.showErrorToast(state.error);
          } else if (state is CategoriesSuccessState) {
            final categories = state.categoriesResponse.categories ?? [];
            final selectedCategory =
                context.read<CategorySelectionCubit>().state;

            if (categories.isNotEmpty && selectedCategory == null) {
              final firstCategory = categories[0];
              context.read<CategorySelectionCubit>().selectCategory(
                0,
                firstCategory.id!,
                firstCategory.name!,
                firstCategory.image!,
              );
              context.read<ProductsCubit>().getProductsByCategory(
                firstCategory.id!,
              );
            }
          }
        },
        builder: (context, state) {
          if (state is CategoriesLoadingState) {
            return const CustomLoadingItem();
          } else if (state is CategoriesSuccessState) {
            final categories = state.categoriesResponse.categories ?? [];

            return BlocBuilder<CategorySelectionCubit, SelectedCategory?>(
              builder: (context, selectedCategory) {
                if (selectedCategory == null && categories.isNotEmpty) {
                  final firstCategory = categories[0];
                  context.read<CategorySelectionCubit>().selectCategory(
                    0,
                    firstCategory.id!,
                    firstCategory.name!,
                    firstCategory.image!,
                  );
                }

                return Container(
                  height: height,
                  color: ColorsManager.lightPrimary,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory?.index == index;

                      return GestureDetector(
                        onTap: () {
                          context.read<CategorySelectionCubit>().selectCategory(
                            index,
                            category.id!,
                            category.name!,
                            category.image!,
                          );
                          context.read<ProductsCubit>().getProductsByCategory(
                            category.id!,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.025,
                            horizontal: width * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? ColorsManager.whiteColor
                                    : Colors.transparent,
                          ),
                          child: Text(
                            CapitalizeText.capitalizeText(category.name!),
                            style: TextStyle(
                              color: ColorsManager.arrowListTile,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is CategoriesErrorState) {
            return Center(child: Text(state.error));
          } else {
            return Center(child: Text(StringManager.errorOccur.tr(context)));
          }
        },
      ),
    );
  }
}
