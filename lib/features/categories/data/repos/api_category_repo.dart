import 'package:dartz/dartz.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/features/categories/data/models/api_categories_response_model.dart';
import 'package:electro/features/categories/presentation/views/widgets/selected_category.dart';

abstract class ApiCategoryRepo {
  Future<Either<Failure, CategoriesResponse>> getCategories();
  // Future<Either<Failure, CategoryProductsModel>> getProductsByCategory(
  //   String categoryId,
  // );
  // SelectedCategory? getSelectedCategory();
  // void setSelectedCategory(SelectedCategory category);
}
