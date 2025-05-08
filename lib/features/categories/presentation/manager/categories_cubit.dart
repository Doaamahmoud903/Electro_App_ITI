import 'package:electro/features/categories/data/repos/api_category_repo.dart';
import 'package:electro/features/categories/presentation/manager/categories_state.dart';
import 'package:electro/features/categories/presentation/views/widgets/selected_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/categories/data/models/api_categories_response_model.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._apiCategoryRepo) : super(CategoriesInitialState());
  final ApiCategoryRepo _apiCategoryRepo;
  static CategoriesCubit get(context) => BlocProvider.of(context);

  /// Get categories
  Future<void> getCategories() async {
    emit(CategoriesLoadingState());
    final response = await _apiCategoryRepo.getCategories();
    print(response);
    response.fold(
      (failure) {
        emit(CategoriesErrorState(failure.errMessage));
      },
      (categoriesResponse) {
        emit(CategoriesSuccessState(categoriesResponse));
      },
    );
  }

  // /// Get products by category ID
  // Future<void> getProductsByCategory(String categoryId) async {
  //   emit(CategoriesLoadingState());
  //   final response = await _apiCategoryRepo.getProductsByCategory(categoryId);

  //   // print(response);
  //   response.fold(
  //     (failure) {
  //       emit(ProductsCategoryErrorState(failure.errMessage));
  //     },
  //     (categoryProductsModel) {
  //       emit(ProductsCategorySuccessState(categoryProductsModel));
  //     },
  //   );
  // }

  // void selectCategory(int index, String id, String name, Image image) {
  //   final selectedCategory = SelectedCategory(
  //     index: index,
  //     id: id,
  //     name: name,
  //     image: image,
  //   );
  //   _apiCategoryRepo.setSelectedCategory(selectedCategory);
  //   emit(SelectedCategoryState(selectedCategory));
  // }

  // SelectedCategory? get selectedCategory =>
  //     _apiCategoryRepo.getSelectedCategory();
}
