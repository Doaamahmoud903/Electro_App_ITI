import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserResponse {
  final String? message;
  final bool? success;
  final User? user;

  UserResponse({this.message, this.success, this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final bool? confirmEmail;
  final String? role;
  final String? status;
  final String? code;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.confirmEmail,
    this.role,
    this.status,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserUpdateResponse {
  final String? message;
  final bool? success;
  final UserUpdated? user;

  UserUpdateResponse({this.message, this.success, this.user});

  factory UserUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateResponseToJson(this);
}

@JsonSerializable()
class UserUpdated {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final bool? confirmEmail;
  final String? role;
  final String? password;
  final String? status;
  final String? code;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserUpdated({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.confirmEmail,
    this.password,
    this.role,
    this.status,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory UserUpdated.fromJson(Map<String, dynamic> json) =>
      _$UserUpdatedFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdatedToJson(this);
}
