import 'package:either_dart/either.dart';
import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_local_datasource.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_local_repository.dart';

class SharedLocalRepositoryImpl implements SharedLocalRepository {
  final SharedLocalDatasource datasource;

  SharedLocalRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> doLogout() async {
    try {
      final result = await datasource.doLogout();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getLoggedUser() async {
    try {
      final result = await datasource.getLoggedUser();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> setLoggedUser(UserEntity user) async {
    try {
      final result = await datasource.setLoggedUser(UserModel.fromEntity(user));
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(msg: e.toString()));
    }
  }
}
