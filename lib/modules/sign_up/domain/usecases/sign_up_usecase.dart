import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/sign_up/domain/entities/request_sign_up_entity.dart';
import 'package:financy_app/modules/sign_up/domain/repositories/sign_up_repository.dart';

abstract class SignUpUseCase
    implements UseCase<UserEntity, RequestSignUpEntity> {}

class SignUpUseCaseImpl implements SignUpUseCase {
  final SignUpRepository repository;

  SignUpUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(RequestSignUpEntity request) async {
    return await repository.signUp(request);
  }
}
