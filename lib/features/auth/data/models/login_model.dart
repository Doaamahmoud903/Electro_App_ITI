import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final String? message;
  final String? token;
  final UserModel? user;
  final bool? success;

  LoginResponseModel({this.message, this.token, this.user, this.success});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final bool? confirmEmail;
  final String? role;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? code;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.confirmEmail,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.code,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse {
  final String? message;
  final bool? success;

  ForgetPasswordResponse({this.message, this.success});

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}

@JsonSerializable()
class SignUpModel {
  final String? message;
  final User? user;
  final bool? success;

  SignUpModel({this.message, this.user, this.success});

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}

@JsonSerializable()
class User {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? password;
  final bool? confirmEmail;
  final String? role;
  final String? status;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.password,
    this.confirmEmail,
    this.role,
    this.status,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
