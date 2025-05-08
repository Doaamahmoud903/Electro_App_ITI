import 'package:electro/features/categories/data/models/api_categories_response_model.dart';
import 'package:electro/features/categories/presentation/views/widgets/selected_category.dart';
import 'package:electro/features/products/data/repo/repo_products.dart';
import 'package:electro/features/products/presentation/manager/products_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit(this._productsRepository) : super(ProductsInitialState());
  final ProductsRepository _productsRepository;

  static ProductsCubit get(context) => BlocProvider.of(context);

  /// get products
  Future<void> getProducts() async {
    emit(ProductsLoadingState());
    final response = await _productsRepository.getProducts();
    //print(response);
    response.fold(
      (failure) {
        emit(ProductsErrorState(failure.errMessage));
      },
      (productsResponse) {
        emit(ProductsSuccessState(productsResponse));
      },
    );
  }

  // get products by page
  Future<void> getProductsByPage({int page = 1}) async {
    emit(ProductsLoadingState());
    final response = await _productsRepository.getProducts();
    //print(response);
    response.fold(
      (failure) {
        emit(ProductsErrorState(failure.errMessage));
      },
      (productsResponse) {
        emit(ProductsSuccessState(productsResponse));
      },
    );
  }

  Future<void> searchProducts(String query) async {
    emit(ProductsLoadingState());
    final result = await _productsRepository.searchProducts(query);

    result.fold((failure) => emit(ProductsErrorState(failure.errMessage)), (
      productsModel,
    ) {
      if (productsModel.products == null || productsModel.products!.isEmpty) {
        emit(ProductsEmpty());
      } else {
        emit(ProductsSuccessState(productsModel));
      }
    });
  }

  Future<void> searchByComparison(String query) async {
    emit(ProductsLoadingState());
    final result = await _productsRepository.searchWithComparison(query);

    result.fold((failure) => emit(ProductsErrorState(failure.errMessage)), (
      comparisonResponse,
    ) {
      if (comparisonResponse.comparison == null ||
          comparisonResponse.comparison!.isEmpty) {
        emit(ProductsEmpty());
      } else {
        emit(SearchByComparisonSuccess(comparisonResponse));
      }
    });
  }

  Future<void> searchSmart(String query) async {
    emit(ProductsLoadingState());

    final result = await _productsRepository.searchProducts(query);

    await result.fold(
      (failure) {
        emit(ProductsErrorState(failure.errMessage));
      },
      (productsModel) async {
        if (productsModel.products == null || productsModel.products!.isEmpty) {
          // If there is no Products, try to search by comparison
          final comparisonResult = await _productsRepository
              .searchWithComparison(query);
          comparisonResult.fold(
            (failure) => emit(ProductsErrorState(failure.errMessage)),
            (comparisonResponse) {
              if (comparisonResponse.comparison == null ||
                  comparisonResponse.comparison!.isEmpty) {
                emit(ProductsEmpty());
              } else {
                emit(SearchByComparisonSuccess(comparisonResponse));
              }
            },
          );
        } else {
          emit(ProductsSuccessState(productsModel));
        }
      },
    );
  }

  /// Get products by category ID
  /// Get products by category ID
  Future<void> getProductsByCategory(String categoryId) async {
    emit(ProductsLoadingState());
    final response = await _productsRepository.getProductsByCategory(
      categoryId,
    );

    // print(response);
    response.fold(
      (failure) {
        emit(ProductsCategoryErrorState(failure.errMessage));
      },
      (categoryProductsModel) {
        emit(ProductsCategorySuccessState(categoryProductsModel));
      },
    );
  }

  void selectCategory(int index, String id, String name, Image image) {
    final selectedCategory = SelectedCategory(
      index: index,
      id: id,
      name: name,
      image: image,
    );
    _productsRepository.setSelectedCategory(selectedCategory);
    emit(SelectedCategoryState(selectedCategory));
  }

  SelectedCategory? get selectedCategory =>
      _productsRepository.getSelectedCategory();
}
