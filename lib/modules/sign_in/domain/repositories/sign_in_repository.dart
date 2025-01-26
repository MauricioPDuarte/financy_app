import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_in/domain/entities/request_sign_in_entity.dart';

abstract class SignInRepository {
  Future<Either<Failure, UserEntity>> signIn(RequestSignInEntity request);
  Future<Either<Failure, UserEntity>> signInWithFacebook();
  Future<Either<Failure, UserEntity>> signInWithGoogle();
}
