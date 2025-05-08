import 'package:dio/dio.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/features/categories/data/repos/api_category_repo_impl.dart';
import 'package:electro/features/categories/presentation/views/widgets/category_content.dart';
import 'package:electro/features/categories/presentation/views/widgets/category_sidebar.dart';
import 'package:electro/features/layout/presentation/views/widgets/app_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/categories/presentation/manager/categories_cubit.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppNavbar(height: height, width: width),
      body: BlocProvider(
        create: (context) {
          final cubit = CategoriesCubit(ApiCategoryRepoImpl(ApiService(Dio())));
          cubit.getCategories();
          return cubit;
        },
        child: const Row(
          children: [
            // Side Menu
            Expanded(flex: 1, child: CategorySidebar()),

            // Content Area
            Expanded(flex: 3, child: CategoryContent()),
          ],
        ),
      ),
    );
  }
}
