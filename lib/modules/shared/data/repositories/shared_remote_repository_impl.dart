import 'package:either_dart/either.dart';
import 'package:financy_app/core/data/services/network_info.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_remote_datasource.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_remote_repository.dart';

class SharedRemoteRepositoryImpl implements SharedRemoteRepository {
  final NetworkInfo networkInfo;
  final SharedRemoteDatasource datasource;

  SharedRemoteRepositoryImpl({
    required this.networkInfo,
    required this.datasource,
  });

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    try {
      if (!(await networkInfo.isConnected)) return Left(NoConnection());

      final result = await datasource.signInWithFacebook();

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      if (!(await networkInfo.isConnected)) return Left(NoConnection());

      final result = await datasource.signInWithGoogle();

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(msg: e.toString()));
    }
  }
}
