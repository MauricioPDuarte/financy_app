import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_remote_repository.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_sign_in_with_facebook_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockSharedRemoteRepository extends Mock
    implements SharedRemoteRepository {}

void main() {
  late SharedRemoteRepository repository;
  late SharedSignInWithFacebookUseCase signInWithFacebookUseCase;

  setUp(() {
    repository = MockSharedRemoteRepository();
    signInWithFacebookUseCase =
        SharedSignInWithFacebookUseCaseImpl(repository: repository);
  });

  test('Deve retornar no lado direito (Either) um UserEntity', () async {
    when(() => repository.signInWithFacebook())
        .thenAnswer((_) async => Right<Failure, UserEntity>(tUserEntity()));

    final result = await signInWithFacebookUseCase(NoParams());

    expect(result, Right<Failure, UserEntity>(tUserEntity()));
  });

  test('Deve retornar no lado esquerno (Either) uma Failure', () async {
    when(() => repository.signInWithFacebook())
        .thenAnswer((_) async => Left<Failure, UserEntity>(tNoConnection()));

    final result = await signInWithFacebookUseCase(NoParams());

    expect(result, Left<Failure, UserEntity>(tNoConnection()));
  });
}
