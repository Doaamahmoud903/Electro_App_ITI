import 'package:electro/features/categories/presentation/views/widgets/selected_category.dart';
import 'package:electro/features/products/data/models/ai_comparison_response.dart';
import 'package:electro/features/products/data/models/api_products_model.dart';
import 'package:electro/features/categories/data/models/api_categories_response_model.dart';

abstract class ProductsStates {}

class ProductsInitialState extends ProductsStates {}

class ProductsLoadingState extends ProductsStates {}

class ProductsSuccessState extends ProductsStates {
  final ProductsModel productsResponse;
  ProductsSuccessState(this.productsResponse);
}

class ProductsErrorState extends ProductsStates {
  final String error;
  ProductsErrorState(this.error);
}

class ProductsEmpty extends ProductsStates {}

class SearchByComparisonSuccess extends ProductsStates {
  final ComparisonResponse comparisonResponse;
  SearchByComparisonSuccess(this.comparisonResponse);
}

class ProductsCategorySuccessState extends ProductsStates {
  final CategoryProductsModel categoryProductsModel;
  ProductsCategorySuccessState(this.categoryProductsModel);
}

class ProductsCategoryErrorState extends ProductsStates {
  final String error;
  ProductsCategoryErrorState(this.error);
}

class SelectedCategoryState extends ProductsStates {
  final SelectedCategory selectedCategory;
  SelectedCategoryState(this.selectedCategory);
}
