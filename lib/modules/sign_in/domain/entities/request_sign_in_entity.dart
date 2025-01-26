import 'package:equatable/equatable.dart';

class RequestSignInEntity extends Equatable {
  final String email;
  final String password;

  const RequestSignInEntity({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
