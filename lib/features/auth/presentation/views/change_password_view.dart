import 'package:dio/dio.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/features/auth/presentation/views/widget/change_password_view_body.dart';
import 'package:electro/features/profile/data/repos/user_repo_implementation.dart';
import 'package:electro/features/profile/presentation/manager/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(UserRepositoryImplement(ApiService(Dio()))),
      child: const ChangePasswordViewBody(),
    );
  }
}
