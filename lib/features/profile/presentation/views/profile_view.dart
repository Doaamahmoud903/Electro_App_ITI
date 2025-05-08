import 'package:dio/dio.dart';
import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/features/profile/data/repos/user_repo_implementation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electro/features/profile/presentation/manager/user_cubit.dart';
import 'package:electro/core/api/api_service.dart';
import 'widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final token = CacheHelper().getData("token");

    return BlocProvider(
      create: (context) {
        final cubit = UserCubit(UserRepositoryImplement(ApiService(Dio())));
        cubit.getUserAccount(token);
        return cubit;
      },
      child: const ProfileViewBody(),
    );
  }
}
