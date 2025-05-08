import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/features/layout/presentation/manager/layout_cubit.dart';
import 'package:electro/features/layout/presentation/views/widgets/bottom_nav_item.dart';
import 'package:flutter/material.dart';

Widget bottomNavbar(BuildContext context) {
  var layoutCubit = LayoutCubit.get(context);

  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: layoutCubit.currentIndex,
    onTap: (index) {
      layoutCubit.changeBottom(index);
    },
    items: [
      BottomNavItem(
        iconName: ImagesAssets.homeIcon,
        index: 0,
        label: "",
        selectedIndex: layoutCubit.currentIndex,
      ),
      BottomNavItem(
        iconName: ImagesAssets.productIcon,
        index: 1,
        label: "",
        selectedIndex: layoutCubit.currentIndex,
      ),
      BottomNavItem(
        iconName: ImagesAssets.categoryIcon,
        index: 2,
        label: "",
        selectedIndex: layoutCubit.currentIndex,
      ),
      BottomNavItem(
        iconName: ImagesAssets.heartIcon,
        index: 3,
        label: "",
        selectedIndex: layoutCubit.currentIndex,
      ),
      BottomNavItem(
        iconName: ImagesAssets.profileIcon,
        index: 4,
        label: "",
        selectedIndex: layoutCubit.currentIndex,
      ),
    ],
  );
}
