import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_local_repository.dart';

abstract class SharedGetLoggedUserUsecase
    implements UseCase<UserEntity?, NoParams> {}

class SharedGetLoggedUserUsecaseImpl implements SharedGetLoggedUserUsecase {
  final SharedLocalRepository repository;

  SharedGetLoggedUserUsecaseImpl({required this.repository});

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getLoggedUser();
  }
}
