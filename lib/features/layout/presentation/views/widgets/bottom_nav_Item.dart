import 'package:electro/core/theming/color_manager.dart';
import 'package:flutter/material.dart';

BottomNavigationBarItem BottomNavItem({
  required String iconName,
  required String label,
  required int index,
  required int selectedIndex,
  //required Function() onTapCallback,
}) {
  return BottomNavigationBarItem(
    icon: GestureDetector(
      //onTap: onTapCallback,
      child:
          selectedIndex == index
              ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: ColorsManager.whiteColor,
                  borderRadius: BorderRadius.circular(66),
                ),
                child: ImageIcon(AssetImage(iconName)),
              )
              : ImageIcon(AssetImage(iconName)),
    ),
    label: label,
  );
}
