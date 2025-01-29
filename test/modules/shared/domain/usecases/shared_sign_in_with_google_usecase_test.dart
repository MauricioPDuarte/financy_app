import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_remote_repository.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_sign_in_with_google_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockSharedRemoteRepository extends Mock
    implements SharedRemoteRepository {}

void main() {
  late SharedRemoteRepository repository;
  late SharedSignInWithGoogleUseCase signInWithGoogleUseCase;

  setUp(() {
    repository = MockSharedRemoteRepository();
    signInWithGoogleUseCase =
        SharedSignInWithGoogleUseCaseImpl(repository: repository);
  });

  test('Deve retornar no lado direito (Either) um UserEntity', () async {
    when(() => repository.signInWithGoogle())
        .thenAnswer((_) async => Right<Failure, UserEntity>(tUserEntity()));

    final result = await signInWithGoogleUseCase(NoParams());

    expect(result, Right<Failure, UserEntity>(tUserEntity()));
  });

  test('Deve retornar no lado esquerno (Either) uma Failure', () async {
    when(() => repository.signInWithGoogle())
        .thenAnswer((_) async => Left<Failure, UserEntity>(tNoConnection()));

    final result = await signInWithGoogleUseCase(NoParams());

    expect(result, Left<Failure, UserEntity>(tNoConnection()));
  });
}
