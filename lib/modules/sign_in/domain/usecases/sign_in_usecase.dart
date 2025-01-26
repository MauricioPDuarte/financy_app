import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/sign_in/domain/entities/request_sign_in_entity.dart';
import 'package:financy_app/modules/sign_in/domain/repositories/sign_in_repository.dart';

abstract class SignInUseCase
    implements UseCase<UserEntity, RequestSignInEntity> {}

class SignInUseCaseImpl implements SignInUseCase {
  final SignInRepository repository;

  SignInUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(RequestSignInEntity request) async {
    return await repository.signIn(request);
  }
}
