// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  message: json['message'] as String?,
  success: json['success'] as bool?,
  user:
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  confirmEmail: json['confirmEmail'] as bool?,
  role: json['role'] as String?,
  status: json['status'] as String?,
  code: json['code'] as String?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'address': instance.address,
  'confirmEmail': instance.confirmEmail,
  'role': instance.role,
  'status': instance.status,
  'code': instance.code,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

UserUpdateResponse _$UserUpdateResponseFromJson(Map<String, dynamic> json) =>
    UserUpdateResponse(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      user:
          json['user'] == null
              ? null
              : UserUpdated.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserUpdateResponseToJson(UserUpdateResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'user': instance.user,
    };

UserUpdated _$UserUpdatedFromJson(Map<String, dynamic> json) => UserUpdated(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  confirmEmail: json['confirmEmail'] as bool?,
  password: json['password'] as String?,
  role: json['role'] as String?,
  status: json['status'] as String?,
  code: json['code'] as String?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserUpdatedToJson(UserUpdated instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'confirmEmail': instance.confirmEmail,
      'role': instance.role,
      'password': instance.password,
      'status': instance.status,
      'code': instance.code,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
