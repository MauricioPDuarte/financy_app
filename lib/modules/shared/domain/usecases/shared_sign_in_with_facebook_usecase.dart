import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_remote_repository.dart';

abstract class SharedSignInWithFacebookUseCase
    implements UseCase<UserEntity, NoParams> {}

class SharedSignInWithFacebookUseCaseImpl
    implements SharedSignInWithFacebookUseCase {
  final SharedRemoteRepository repository;

  SharedSignInWithFacebookUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.signInWithFacebook();
  }
}
