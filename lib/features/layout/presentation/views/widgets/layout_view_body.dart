import 'package:electro/features/layout/presentation/manager/layout_cubit.dart';
import 'package:electro/features/layout/presentation/manager/layout_states.dart';
import 'package:electro/features/layout/presentation/views/widgets/botton_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutViewBody extends StatelessWidget {
  const LayoutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (BuildContext context, LayoutStates state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: bottomNavbar(context),
        );
      },
    );
  }
}
