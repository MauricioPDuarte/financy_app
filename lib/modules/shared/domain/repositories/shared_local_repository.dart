import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';

abstract class SharedLocalRepository {
  Future<Either<Failure, bool>> setLoggedUser(UserEntity user);
  Future<Either<Failure, UserEntity?>> getLoggedUser();
  Future<Either<Failure, bool>> doLogout();
}
