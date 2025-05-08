import 'package:electro/core/theming/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const SecondAppbar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: ColorsManager.whiteColor),
        onPressed: () => context.pop(),
      ),
      backgroundColor: ColorsManager.primary,
      foregroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        name,
        style: TextStyle(color: ColorsManager.whiteColor, fontSize: 24),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
