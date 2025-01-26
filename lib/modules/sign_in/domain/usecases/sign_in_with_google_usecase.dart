import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/sign_in/domain/repositories/sign_in_repository.dart';

abstract class SignInWithGoogleUseCase
    implements UseCase<UserEntity, NoParams> {}

class SignInWithGoogleUseCaseImpl implements SignInWithGoogleUseCase {
  final SignInRepository repository;

  SignInWithGoogleUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.signInWithGoogle();
  }
}
