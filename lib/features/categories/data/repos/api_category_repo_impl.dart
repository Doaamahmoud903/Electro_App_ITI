import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:electro/core/api/api_constant.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/errors/failures.dart';
import 'package:electro/core/errors/models/api_error_model.dart';
import 'package:electro/features/categories/data/models/api_categories_response_model.dart';
import 'package:electro/features/categories/data/repos/api_category_repo.dart';
import 'package:electro/features/categories/presentation/views/widgets/selected_category.dart';

class ApiCategoryRepoImpl extends ApiCategoryRepo {
  final ApiService _apiService;
  ApiCategoryRepoImpl(this._apiService);

  // =================== get categories ===================
  @override
  Future<Either<Failure, CategoriesResponse>> getCategories() async {
    try {
      var response = await _apiService.get(endPoint: ApiConstant.categories);
      return right(CategoriesResponse.fromJson(response));
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

  // @override
  // Future<Either<Failure, CategoryProductsModel>> getProductsByCategory(
  //   String categoryId,
  // ) async {
  //   try {
  //     var request = await _apiService.get(
  //       endPoint: '${ApiConstant.products}?category=$categoryId',
  //     );
  //     return right(CategoryProductsModel.fromJson(request));
  //   } catch (error) {
  //     if (error is DioException) {
  //       return left(
  //         ServerFailure.fromResponse(
  //           error.response?.statusCode,
  //           ApiErrorResponse.fromJson(error.response?.data),
  //         ),
  //       );
  //     } else {
  //       return left(ServerFailure('Something went wrong ${error.toString()}'));
  //     }
  //   }
  // }

  // SelectedCategory? _selectedCategory;
  // void setSelectedCategory(SelectedCategory category) {
  //   _selectedCategory = category;
  // }

  // @override
  // SelectedCategory? getSelectedCategory() {
  //   return _selectedCategory;
  // }
}
