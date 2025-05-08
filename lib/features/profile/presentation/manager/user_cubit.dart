import 'package:bloc/bloc.dart';
import 'package:electro/features/profile/data/repos/user_repo.dart';
import 'package:electro/features/profile/presentation/manager/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;
  String name = '';
  String email = '';

  UserCubit(this.userRepo) : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);

  Future<void> getUserAccount(String token) async {
    emit(GetUserLoading());

    final result = await userRepo.getUserAccount(token);
    result.fold((failure) => emit(GetUserFailure(failure.errMessage)), (
      userResponse,
    ) {
      name = userResponse.user!.name!;
      email = userResponse.user!.email!;
      emit(GetUserSuccess(userResponse));
    });
  }

  Future<void> updateUserAccount({
    required String name,
    required String email,
    required String token,
  }) async {
    emit(UpdateUserLoading());

    final result = await userRepo.updateUserAccount(name, email, token);
    result.fold((failure) => emit(UpdateUserFailure(failure.errMessage)), (
      updateResponse,
    ) {
      // Update local state
      name = name;
      email = email;
      emit(UpdateUserSuccess(updateResponse));
    });
  }

  void updateName(String newName) {
    name = newName;
    emit(UserDataChanged());
  }

  void updateEmail(String newEmail) {
    email = newEmail;
    emit(UserDataChanged());
  }

  // Change Password method
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    emit(ChangePasswordLoading());
    final response = await userRepo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      token: token,
    );
    print(response);
    response.fold(
      (failure) {
        print('❌ Failure: ${failure.errMessage}');
        emit(ChangePasswordFailure(failure.errMessage));
      },

      (changePasswordResponse) {
        emit(ChangePasswordSuccess(changePasswordResponse));
      },
    );
  }
}
