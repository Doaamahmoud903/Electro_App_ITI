import 'package:dio/dio.dart';
import 'package:electro/core/api/api_service.dart';
import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/features/account/presentation/views/widgets/account_view_body.dart';
import 'package:electro/features/profile/data/repos/user_repo_implementation.dart';
import 'package:electro/features/profile/presentation/manager/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountView extends StatelessWidget {
  AccountView({super.key});
  String token = CacheHelper().getData('token');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = UserCubit(UserRepositoryImplement(ApiService(Dio())));
        cubit.getUserAccount(token);
        return cubit;
      },
      child: AccountViewBody(),
    );
  }
}
