import 'package:electro/core/functions/build_app_root.dart';
import 'package:electro/core/state_management/app_bloc_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElectroApp extends StatelessWidget {
  const ElectroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appBlocProviders(),
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(360, 690),
        child: buildAppRoot(context),
      ),
    );
  }
}
