import 'package:electro/core/di/di.dart';
import 'package:electro/features/cart/data/repos/cart_repo_implemtation.dart';
import 'package:electro/features/cart/presentation/manager/cart_cubit.dart';
import 'package:electro/features/products/data/repo/repo_implement_products.dart';
import 'package:electro/features/products/presentation/manager/products_cubit.dart';
import 'package:electro/features/products/presentation/views/widgets/products_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(getIt.get<CartRepoImplemtation>()),
        ),
        BlocProvider<ProductsCubit>(
          create:
              (_) =>
                  ProductsCubit(getIt.get<ProductsRepositoryImplement>())
                    ..getProducts(),
        ),
      ],
      child: const ProductsViewBody(),
    );
  }
}
