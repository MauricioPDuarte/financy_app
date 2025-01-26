import 'package:either_dart/either.dart';
import 'package:financy_app/core/data/services/network_info.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_in/data/datasources/sign_in_datasource.dart';
import 'package:financy_app/modules/sign_in/data/models/request_sign_in_model.dart';
import 'package:financy_app/modules/sign_in/domain/entities/request_sign_in_entity.dart';
import 'package:financy_app/modules/sign_in/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInDatasource datasource;
  final NetworkInfo networkInfo;

  SignInRepositoryImpl({required this.datasource, required this.networkInfo});

  @override
  Future<Either<Failure, UserEntity>> signIn(
      RequestSignInEntity request) async {
    try {
      if (!(await networkInfo.isConnected)) return Left(NoConnection());

      final result =
          await datasource.signIn(RequestSignInModel.fromEntity(request));

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(msg: e.toString()));
    }
  }

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
