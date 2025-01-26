import 'dart:convert';

import 'package:financy_app/core/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.avatarUrl,
    super.email,
    super.fullName,
    super.id,
    super.password,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      fullName: entity.fullName,
      avatarUrl: entity.avatarUrl,
      password: entity.password,
      email: entity.email,
    );
  }

  factory UserModel.fromJson(String json) {
    return UserModel.fromMap(jsonDecode(json) as Map<String, dynamic>);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      avatarUrl: map['avatar_url'],
      email: map['email'],
      password: map['password'],
      id: map['id'],
      fullName: map['full_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'avatar_url': avatarUrl,
      'email': email,
      'password': password,
      'id': id,
      'full_name': fullName,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
