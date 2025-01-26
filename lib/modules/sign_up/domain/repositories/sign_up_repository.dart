import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_up/domain/entities/request_sign_up_entity.dart';

abstract class SignUpRepository {
  Future<Either<Failure, UserEntity>> signUp(RequestSignUpEntity request);
}
