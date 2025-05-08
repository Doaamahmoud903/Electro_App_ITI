import 'package:dartz/dartz.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/features/categories/data/models/api_categories_response_model.dart';
import 'package:electro/features/categories/presentation/views/widgets/selected_category.dart';
import 'package:electro/features/products/data/models/ai_comparison_response.dart';
import 'package:electro/features/products/data/models/api_products_model.dart';

abstract class ProductsRepository {
  Future<Either<Failure, ProductsModel>> getProducts();
  Future<Either<Failure, ProductsModel>> getProductsByPage(int page);
  Future<Either<Failure, ProductsModel>> searchProducts(String query);
  Future<Either<Failure, CategoryProductsModel>> getProductsByCategory(
    String categoryId,
  );
  SelectedCategory? getSelectedCategory();
  void setSelectedCategory(SelectedCategory category);
  Future<Either<Failure, ComparisonResponse>> searchWithComparison(
    String query,
  );
}
