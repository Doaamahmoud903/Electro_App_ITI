import 'package:dio/dio.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/features/categories/data/repos/api_category_repo_impl.dart';
import 'package:electro/features/categories/presentation/manager/categories_cubit.dart';
import 'package:electro/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:electro/features/products/data/repo/repo_implement_products.dart';
import 'package:electro/features/products/presentation/manager/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../categories/presentation/views/widgets/category_selection_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  CategoriesCubit(ApiCategoryRepoImpl(ApiService(Dio())))
                    ..getCategories(),
        ),
        BlocProvider(
          create:
              (_) =>
                  ProductsCubit(ProductsRepositoryImplement(ApiService(Dio())))
                    ..getProducts(),
        ),

      ],
      child: const HomeViewBody(),
    );
  }
}
