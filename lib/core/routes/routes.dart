import 'package:dio/dio.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/di/di.dart';
import 'package:electro/features/account/presentation/views/account_view.dart';
import 'package:electro/features/account/presentation/views/widgets/account_view_body.dart';
import 'package:electro/features/auth/data/repos/auth_repo_implemtation.dart';
import 'package:electro/features/auth/presentation/manager/auth_cubit.dart';
import 'package:electro/features/auth/presentation/views/change_password_view.dart';
import 'package:electro/features/auth/presentation/views/forget_password_view.dart';
import 'package:electro/features/auth/presentation/views/login_view.dart';
import 'package:electro/features/auth/presentation/views/reset_password_view.dart';
import 'package:electro/features/auth/presentation/views/sign_up_view.dart';
import 'package:electro/features/cart/data/repos/cart_repo_implemtation.dart';
import 'package:electro/features/cart/presentation/manager/cart_cubit.dart';
import 'package:electro/features/cart/presentation/views/cart_view.dart';
import 'package:electro/features/categories/presentation/views/categories_view.dart';
import 'package:electro/features/layout/presentation/views/layout_view.dart';
import 'package:electro/features/onboarding/presentation/views/splash_view.dart';
import 'package:electro/features/orders/data/models/orders_model.dart';
import 'package:electro/features/orders/data/repos/orders_repo_implemtation.dart';
import 'package:electro/features/orders/presentation/manager/orders_cubit.dart';
import 'package:electro/features/orders/presentation/views/orders_view.dart';
import 'package:electro/features/orders/presentation/views/widgets/create_orders_view.dart';
import 'package:electro/features/products/data/models/api_products_model.dart';
import 'package:electro/features/products/presentation/views/products_view.dart';
import 'package:electro/features/products/presentation/views/widgets/product_details.dart';
import 'package:electro/features/profile/data/repos/user_repo_implementation.dart';
import 'package:electro/features/profile/presentation/manager/user_cubit.dart';
import 'package:electro/features/profile/presentation/views/profile_view.dart';
import 'package:electro/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:electro/features/reviews/data/repos/reviews_repo_implementation.dart';
import 'package:electro/features/reviews/presentation/manager/reviews_cubit.dart';
import 'package:electro/features/reviews/presentation/views/reviews_view.dart';
import 'package:electro/features/reviews/presentation/views/widgets/reviews_view_body.dart';
import 'package:electro/features/wishlist/presentation/views/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:electro/features/account/presentation/manager/pic_lang_cubit.dart';

class AppRoutes {
  // static const splashView = Routes.splashView;
  static const cartView = Routes.cart;

  static String? token;
  static Future<void> init() async {
    // Initialize CacheHelper or whatever you need before getting the token
    token = await CacheHelper().getData("token");
    print("access TOKEN >>><<<<< $token");
  }

  static final routes = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        pageBuilder: (context, state) {
          if (token != null) {
            return _fadePageBuilder(const LayoutView(), state);
          } else {
            return _fadePageBuilder(const SplashView(), state);
          }
        },
      ),
      GoRoute(
        path: Routes.layout,
        name: Routes.layout,
        pageBuilder:
            (context, state) => _fadePageBuilder(const LayoutView(), state),
      ),
      GoRoute(
        path: Routes.productDetailsScreen,
        name: Routes.productDetailsScreen,
        pageBuilder: (context, state) {
          final product = state.extra as Product;
          return _fadePageBuilder(
            ProductDetailsScreen(product: product),
            state,
          );
        },
      ),

      GoRoute(
        path: Routes.login,
        name: Routes.login,
        pageBuilder: (context, state) {
          return _fadePageBuilder(
            BlocProvider(
              create:
                  (context) =>
                      AuthCubit(getIt.get<AuthRepositoryImplementation>()),
              child: const LoginView(),
            ),
            state,
          );
        },
      ),
      GoRoute(
        path: Routes.orders,
        pageBuilder: (context, state) {
          return _fadePageBuilder(
            BlocProvider(
              create:
                  (context) =>
                      OrdersCubit(getIt.get<OrdersRepositoryImplementation>()),
              child: const OrdersView(),
            ),
            state,
          );
        },
      ),
      GoRoute(
        path: Routes.addOrders,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final token = data['token'] as String;
          final cartId = data['cartId'] as String;

          return _fadePageBuilder(
            BlocProvider(
              create:
                  (context) =>
                      OrdersCubit(getIt.get<OrdersRepositoryImplementation>()),
              child: CreateOrdersView(token: token, cartId: cartId),
            ),
            state,
          );
        },
      ),

      GoRoute(
        path: Routes.logout,
        name: Routes.logout,
        pageBuilder: (context, state) {
          return _fadePageBuilder(
            BlocProvider(
              create:
                  (context) =>
                      AuthCubit(getIt.get<AuthRepositoryImplementation>()),
              child: const LoginView(),
            ),
            state,
          );
        },
      ),
      GoRoute(
        path: Routes.resetPasswordView,
        pageBuilder:
            (context, state) =>
                _fadePageBuilder(const ResetPasswordView(), state),
      ),
      GoRoute(
        path: Routes.signup,
        pageBuilder: (context, state) {
          return _fadePageBuilder(
            BlocProvider(
              create:
                  (context) =>
                      AuthCubit(getIt.get<AuthRepositoryImplementation>()),
              child: const SignUpView(),
            ),
            state,
          );
        },
      ),
      GoRoute(
        path: Routes.forgetPasswordView,
        pageBuilder:
            (context, state) =>
                _fadePageBuilder(const ForgetPasswordView(), state),
      ),

      GoRoute(
        path: Routes.changePasswordView,
        pageBuilder:
            (context, state) => _fadePageBuilder(
              BlocProvider(
                create:
                    (context) =>
                        UserCubit(UserRepositoryImplement(ApiService(Dio()))),
                child: const ChangePasswordView(),
              ),
              state,
            ),
      ),
      GoRoute(
        path: Routes.wishlistView,
        pageBuilder:
            (context, state) => _fadePageBuilder(const WishlistView(), state),
      ),
      GoRoute(
        path: Routes.reviewsView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create:
                (_) =>
                    ReviewCubit(ReviewsRepoImplementation(ApiService(Dio()))),
            child: ReviewsView(extra: extra),
          );
        },
      ),

      GoRoute(
        path: Routes.cart,
        pageBuilder:
            (context, state) => _fadePageBuilder(const CartView(), state),
      ),
      GoRoute(
        path: Routes.categoriesView,
        pageBuilder:
            (context, state) => _fadePageBuilder(const CategoriesView(), state),
      ),
      GoRoute(
        path: Routes.accountView,
        pageBuilder:
            (context, state) => _fadePageBuilder(
              BlocProvider<PicLangCubit>(
                create: (context) => PicLangCubit(),
                child: AccountView(),
              ),
              state,
            ),
      ),
      GoRoute(
        path: Routes.profileView,
        builder: (context, state) {
          return BlocProvider(
            create:
                (_) => UserCubit(UserRepositoryImplement(ApiService(Dio()))),
            child: ProfileView(),
          );
        },
      ),

      // GoRoute(
      //   path: Routes.account,
      //   builder:
      //       (context, state) => BlocProvider(
      //         create:
      //             (context) =>
      //                 UserCubit(UserRepositoryImplement(ApiService(Dio()))),
      //         child: const AccountViewBody(),
      //       ),
      // ),
      GoRoute(
        path: Routes.productsView,
        pageBuilder:
            (context, state) => _fadePageBuilder(const ProductsView(), state),
      ),
    ],
  );

  static Page<dynamic> _fadePageBuilder(Widget child, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeAnimation = Tween(begin: 0.4, end: 1.0).animate(animation);
        return FadeTransition(opacity: fadeAnimation, child: child);
      },
    );
  }
}

class Routes {
  ///==================  view ==========================
  static const splashView = '/SplashScreen';
  static const notificationView = '/notificationView';
  static const layout = '/layout';
  static const welcome = '/welcome';
  static const cart = '/cart';
  static const login = '/login';
  static const logout = '/logout';
  static const forgetPasswordView = '/forgetPasswordView';
  static const resetPasswordView = '/resetPasswordView';
  static const changePasswordView = '/changePasswordView';
  static const signup = '/signup';
  static const profileView = '/profileView';
  static const accountView = '/accountView';
  static const wishlistView = '/wishlistView';
  static const productsView = '/productsView';
  static const categoriesView = '/categoriesView';
  static const orders = '/orders';
  static const addOrders = '/addOrders';
  static const reviewsView = '/reviewsView';
  static const productDetailsScreen = '/productDetailsScreen';
  static const account = '/account';
}
