import 'package:either_dart/either.dart';
import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/network_info.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_up/data/datasources/sign_up_datasource.dart';
import 'package:financy_app/modules/sign_up/data/models/request_sign_up_model.dart';
import 'package:financy_app/modules/sign_up/domain/entities/request_sign_up_entity.dart';
import 'package:financy_app/modules/sign_up/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpDatasource datasource;
  final NetworkInfo networkInfo;

  SignUpRepositoryImpl({
    required this.datasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserModel>> signUp(RequestSignUpEntity request) async {
    try {
      if (!(await networkInfo.isConnected)) return Left(NoConnection());

      final result =
          await datasource.signUp(RequestSignUpModel.fromEntity(request));

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(msg: e.toString()));
    }
  }
}
