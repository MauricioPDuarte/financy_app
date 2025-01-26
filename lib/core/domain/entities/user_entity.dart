import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? avatarUrl;

  const UserEntity({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, fullName, email, password, avatarUrl];
}
