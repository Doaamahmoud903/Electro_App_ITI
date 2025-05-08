import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:electro/core/api/api_constant.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/core/errors/models/api_error_model.dart';
import 'package:electro/features/categories/data/models/api_categories_response_model.dart';
import 'package:electro/features/categories/presentation/views/widgets/selected_category.dart';
import 'package:electro/features/products/data/models/ai_comparison_response.dart';
import 'package:electro/features/products/data/models/api_products_model.dart';
import 'package:electro/features/products/data/repo/repo_products.dart';

class ProductsRepositoryImplement extends ProductsRepository {
  final ApiService _apiService;

  ProductsRepositoryImplement(this._apiService);

  /// Fetch all products
  @override
  Future<Either<Failure, ProductsModel>> getProducts() async {
    try {
      var request = await _apiService.get(endPoint: ApiConstant.products);
      return right(ProductsModel.fromJson(request));
    } catch (error) {
      if (error is DioException) {
        return left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductsModel>> getProductsByPage(int page) async {
    try {
      var request = await _apiService.get(
        endPoint: "${ApiConstant.products}?page=$page",
      );
      return right(ProductsModel.fromJson(request));
    } catch (error) {
      if (error is DioException) {
        return left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductsModel>> searchProducts(String query) async {
    try {
      final response = await _apiService.get(
        endPoint: ApiConstant.products,
        queryParameters: {'search': query},
      );
      return right(ProductsModel.fromJson(response));
    } catch (error) {
      if (error is DioException) {
        return left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return left(ServerFailure('Something went wrong: ${error.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, ComparisonResponse>> searchWithComparison(
    String query,
  ) async {
    try {
      final dio = Dio(BaseOptions(baseUrl: ""));

      final response = await dio.post(
        "https://elctroai.vercel.app/api/compare",
        data: {"query": query},
      );

      return right(ComparisonResponse.fromJson(response.data));
    } catch (error) {
      if (error is DioException) {
        return left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return left(ServerFailure('Something went wrong: ${error.toString()}'));
      }
    }
  }

  /// Fetch products by category ID

  @override
  Future<Either<Failure, CategoryProductsModel>> getProductsByCategory(
    String categoryId,
  ) async {
    try {
      var request = await _apiService.get(
        endPoint: '${ApiConstant.products}?category=$categoryId',
      );
      return right(CategoryProductsModel.fromJson(request));
    } catch (error) {
      if (error is DioException) {
        return left(
          ServerFailure.fromResponse(
            error.response?.statusCode,
            ApiErrorResponse.fromJson(error.response?.data),
          ),
        );
      } else {
        return left(ServerFailure('Something went wrong ${error.toString()}'));
      }
    }
  }

  SelectedCategory? _selectedCategory;
  void setSelectedCategory(SelectedCategory category) {
    _selectedCategory = category;
  }

  @override
  SelectedCategory? getSelectedCategory() {
    return _selectedCategory;
  }
}
