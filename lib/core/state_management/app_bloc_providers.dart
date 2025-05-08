import 'package:dio/dio.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/di/di.dart';
import 'package:electro/core/localization/locale_cubit/locale_cubit.dart';
import 'package:electro/core/state_management/app_cubit/app_cubit.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/features/account/presentation/manager/pic_lang_cubit.dart';
import 'package:electro/features/auth/data/repos/auth_repo_implemtation.dart';
import 'package:electro/features/auth/presentation/manager/auth_cubit.dart';
import 'package:electro/features/auth/presentation/views/login_view.dart';
import 'package:electro/features/cart/data/repos/cart_repo_implemtation.dart';
import 'package:electro/features/cart/presentation/manager/cart_cubit.dart';
import 'package:electro/features/categories/data/repos/api_category_repo_impl.dart';
import 'package:electro/features/categories/presentation/manager/categories_cubit.dart';
import 'package:electro/features/categories/presentation/views/widgets/category_selection_cubit.dart';
import 'package:electro/features/layout/presentation/manager/layout_cubit.dart';
import 'package:electro/features/orders/data/repos/orders_repo_implemtation.dart';
import 'package:electro/features/orders/presentation/manager/orders_cubit.dart';
import 'package:electro/features/products/data/repo/repo_implement_products.dart';
import 'package:electro/features/products/presentation/manager/products_cubit.dart';
import 'package:electro/features/profile/presentation/manager/user_cubit.dart';
import 'package:electro/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:electro/features/reviews/data/repos/reviews_repo_implementation.dart';
import 'package:electro/features/wishlist/data/repos/wishlist_repo_implemtation.dart';
import 'package:electro/features/wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> appBlocProviders() => [
  BlocProvider<AppCubit>(create: (context) => AppCubit()),
  BlocProvider<LocaleCubit>(
    create: (context) => LocaleCubit()..getSavedLanguage(),
  ),
  BlocProvider<LayoutCubit>(create: (context) => LayoutCubit()),
  BlocProvider<CategoriesCubit>(
    create:
        (context) =>
            CategoriesCubit(getIt.get<ApiCategoryRepoImpl>())..getCategories(),
  ),
  BlocProvider<ProductsCubit>(
    create:
        (context) =>
            ProductsCubit(getIt.get<ProductsRepositoryImplement>())
              ..getProducts(),
  ),
  BlocProvider<AuthCubit>(
    create: (context) => AuthCubit(getIt.get<AuthRepositoryImplementation>()),
  ),
  BlocProvider<CartCubit>(
    create: (context) => CartCubit(getIt.get<CartRepoImplemtation>()),
  ),
  BlocProvider<WishlistCubit>(
    create: (context) => WishlistCubit(getIt.get<WishlistRepositoryImple>()),
  ),
  BlocProvider<OrdersCubit>(
    create:
        (context) => OrdersCubit(getIt.get<OrdersRepositoryImplementation>()),
  ),

  BlocProvider<PicLangCubit>(create: (context) => PicLangCubit()),
  BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
  BlocProvider<CategorySelectionCubit>(
    create: (context) => CategorySelectionCubit(),
  ),
];
