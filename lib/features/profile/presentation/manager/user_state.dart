import 'package:electro/features/auth/data/models/login_model.dart';
import 'package:equatable/equatable.dart';
import 'package:electro/features/profile/data/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class GetUserLoading extends UserState {}

class GetUserSuccess extends UserState {
  final UserResponse userResponse;

  const GetUserSuccess(this.userResponse);

  @override
  List<Object?> get props => [userResponse];
}

class GetUserFailure extends UserState {
  final String error;

  const GetUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateUserLoading extends UserState {}

class UpdateUserSuccess extends UserState {
  final UserUpdateResponse updateResponse;

  const UpdateUserSuccess(this.updateResponse);

  @override
  List<Object?> get props => [updateResponse];
}

class UpdateUserFailure extends UserState {
  final String error;

  const UpdateUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class UserDataChanged extends UserState {}

class ChangePasswordLoading extends UserState {}

class ChangePasswordFailure extends UserState {
  final String error;
  ChangePasswordFailure(this.error);
}

class ChangePasswordSuccess extends UserState {
  final UserUpdateResponse changePasswordResponse;
  ChangePasswordSuccess(this.changePasswordResponse);
}
