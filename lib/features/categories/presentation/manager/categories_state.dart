import 'package:electro/features/categories/data/models/api_categories_response_model.dart';
import 'package:electro/features/categories/presentation/views/widgets/selected_category.dart';

abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final CategoriesResponse categoriesResponse;
  CategoriesSuccessState(this.categoriesResponse);
}

class CategoriesErrorState extends CategoriesState {
  final String error;
  CategoriesErrorState(this.error);
}

// class ProductsCategorySuccessState extends CategoriesState {
//   final CategoryProductsModel categoryProductsModel;
//   ProductsCategorySuccessState(this.categoryProductsModel);
// }

// class ProductsCategoryErrorState extends CategoriesState {
//   final String error;
//   ProductsCategoryErrorState(this.error);
// }

// class SelectedCategoryState extends CategoriesState {
//   final SelectedCategory selectedCategory;
//   SelectedCategoryState(this.selectedCategory);
// }
