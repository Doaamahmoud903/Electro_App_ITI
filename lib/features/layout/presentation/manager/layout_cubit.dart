import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../account/presentation/views/account_view.dart';
import '../../../categories/presentation/views/categories_view.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../products/presentation/views/products_view.dart';
import '../../../wishlist/presentation/views/wishlist_view.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  final List<Widget> bottomScreens = [
    const HomeView(),
    const ProductsView(),
    const CategoriesView(),
    const WishlistView(),
    AccountView(),
  ];

  int currentIndex = 0;
  void changeBottom(int index) {
    currentIndex = index;
    emit((LayoutChangeBottomNavState()));
  }

  void goToProductsView() {
    currentIndex = 1;
    emit(LayoutChangeBottomNavState());
  }

  void goToCategoriesView() {
    currentIndex = 2;
    emit(LayoutChangeBottomNavState());
  }
}
