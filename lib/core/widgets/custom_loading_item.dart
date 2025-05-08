import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingItem extends StatefulWidget {
  const CustomLoadingItem({super.key});

  @override
  CustomLoadingItemState createState() => CustomLoadingItemState();
}

class CustomLoadingItemState extends State<CustomLoadingItem>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLightMode = context.read<ThemeCubit>().isLightMode;

    return Center(
      child: SpinKitRipple(
        color:
            isLightMode ? ColorsManager.primaryLight : ColorsManager.whiteColor,
        size: 80.0,
        controller: _controller,
      ),
    );
  }
}
