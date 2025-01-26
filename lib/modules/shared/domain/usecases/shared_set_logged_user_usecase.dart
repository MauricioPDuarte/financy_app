import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_local_repository.dart';

abstract class SharedSetLoggedUserUsecase
    implements UseCase<bool, UserEntity> {}

class SharedSetLoggedUserUsecaseImpl implements SharedSetLoggedUserUsecase {
  final SharedLocalRepository repository;

  SharedSetLoggedUserUsecaseImpl({required this.repository});

  @override
  Future<Either<Failure, bool>> call(UserEntity user) async {
    return await repository.setLoggedUser(user);
  }
}
