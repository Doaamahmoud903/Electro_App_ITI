import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class UserCircleImage extends StatelessWidget {
  const UserCircleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 45,

            backgroundColor: ColorsManager.whiteColor,

            child: const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(ImagesAssets.profileIcon),
            ),
          ),
        ),
        Positioned(
          right: 0,

          child: CircleAvatar(
            radius: 16,
            backgroundColor: ColorsManager.whiteColor,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: const Color(0xff004BFE),
              child: Icon(
                Icons.edit,
                color: ColorsManager.whiteColor,
                size: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
