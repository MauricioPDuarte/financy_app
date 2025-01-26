import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_local_repository.dart';

abstract class SharedLogoutUserUsecase implements UseCase<bool, NoParams> {}

class SharedLogoutUserUsecaseImpl implements SharedLogoutUserUsecase {
  final SharedLocalRepository repository;

  SharedLogoutUserUsecaseImpl({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.doLogout();
  }
}
