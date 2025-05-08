import 'package:dio/dio.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/api/dio_factory.dart';
import 'package:electro/features/auth/data/repos/auth_repo_implemtation.dart';
import 'package:electro/features/cart/data/repos/cart_repo_implemtation.dart';
import 'package:electro/features/categories/data/repos/api_category_repo_impl.dart';
import 'package:electro/features/orders/data/repos/orders_repo_implemtation.dart';
import 'package:electro/features/products/data/repo/repo_implement_products.dart';
import 'package:electro/features/wishlist/data/repos/wishlist_repo_implemtation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  Dio dio = DioFactory.getDio();

  getIt.registerSingleton<ApiService>(ApiService(dio));

  //Example of DI
  getIt.registerSingleton<AuthRepositoryImplementation>(
    AuthRepositoryImplementation(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<ApiCategoryRepoImpl>(
    ApiCategoryRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<ProductsRepositoryImplement>(
    ProductsRepositoryImplement(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<CartRepoImplemtation>(
    CartRepoImplemtation(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<WishlistRepositoryImple>(
    WishlistRepositoryImple(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<OrdersRepositoryImplementation>(
    OrdersRepositoryImplementation(apiService: getIt.get<ApiService>()),
  );
}
