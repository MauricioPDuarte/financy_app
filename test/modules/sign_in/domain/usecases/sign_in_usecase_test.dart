import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:financy_app/modules/sign_in/domain/usecases/sign_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockSignInRepository extends Mock implements SignInRepository {}

void main() {
  late SignInRepository repository;
  late SignInUseCase signInUseCase;

  setUp(() {
    repository = MockSignInRepository();
    signInUseCase = SignInUseCaseImpl(repository: repository);
  });

  group('Test SignInUseCase', () {
    test('Deve retornar no lado direito (Either) um UserEntity', () async {
      when(() => repository.signIn(tRequestSignInEntity()))
          .thenAnswer((_) async => Right<Failure, UserEntity>(tUserEntity()));

      final result = await signInUseCase(tRequestSignInEntity());

      expect(result, Right<Failure, UserEntity>(tUserEntity()));
    });

    test('Deve retornar no lado esquerno (Either) uma Failure', () async {
      when(() => repository.signIn(tRequestSignInEntity()))
          .thenAnswer((_) async => Left<Failure, UserEntity>(tNoConnection()));

      final result = await signInUseCase(tRequestSignInEntity());

      expect(result, Left<Failure, UserEntity>(tNoConnection()));
    });
  });
}
