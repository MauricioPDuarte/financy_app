import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get msg;

  @override
  List<Object?> get props => [];
}

/// No internet connection
class NoConnection extends Failure {
  @override
  String get msg => 'Sorry! You not have connection!';
}

class ApiFailure extends Failure {
  @override
  String get msg => 'Sorry! It was not possible to access the Server';
}

class UnexpectedFailure extends Failure {
  @override
  final String msg;

  UnexpectedFailure({String? msg})
      : msg = msg ??
            'Ocorreu um erro inesperado na aplicação. Entre em contato com o suporte!';
}

class SignUpFailure extends Failure {
  @override
  final String msg;

  SignUpFailure({String? msg})
      : msg = msg ??
            'Ocorreu um erro ao criar sua conta na plataforma Visia. Por favor, tente novamente.';
}

class SignUpEmailAlreadyExistsFailure extends Failure {
  @override
  final String msg;

  SignUpEmailAlreadyExistsFailure({String? msg})
      : msg = msg ??
            'O email informado já esta em uso. Por favor, informe outro email.';
}

class SignUpWeakPasswordFailure extends Failure {
  @override
  final String msg;

  SignUpWeakPasswordFailure({String? msg})
      : msg = msg ??
            'A senha informada não atende os critérios de segurança. Por favor, informe outra senha.';
}

class SignInFailure extends Failure {
  @override
  final String msg;

  SignInFailure({String? msg})
      : msg = msg ??
            'Ocorreu um erro ao tentar acessar sua conta na plataforma Visia. Por favor, tente novamente.';
}

class SignInUserNotFoundFailure extends Failure {
  @override
  final String msg;

  SignInUserNotFoundFailure({String? msg})
      : msg = msg ?? 'E-mail ou senha inválidos. Por favor, tente novamente.';
}

class SignInWrongPasswordFailure extends Failure {
  @override
  final String msg;

  SignInWrongPasswordFailure({String? msg})
      : msg = msg ?? 'E-mail ou senha inválidos. Por favor, tente novamente.';
}

class SignOutFailure extends Failure {
  @override
  final String msg;

  SignOutFailure({String? msg})
      : msg = msg ??
            'Ocorreu um erro ao tentar deslogar da sua conta na plataforma Visia. Por favor, tente novamente.';
}
