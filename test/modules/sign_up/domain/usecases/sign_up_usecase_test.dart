import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:financy_app/modules/sign_up/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockSignUpRepository extends Mock implements SignUpRepository {}

void main() {
  late SignUpRepository repository;
  late SignUpUseCase signUpUseCase;

  setUp(() {
    repository = MockSignUpRepository();
    signUpUseCase = SignUpUseCaseImpl(repository: repository);
  });

  group('Test SignUpUseCase', () {
    test('Deve retornar no lado direito (Either) um UserEntity', () async {
      when(() => repository.signUp(tRequestSignUpEntity()))
          .thenAnswer((_) async => Right<Failure, UserEntity>(tUserEntity()));

      final result = await signUpUseCase(tRequestSignUpEntity());

      expect(result, Right<Failure, UserEntity>(tUserEntity()));
    });

    test('Deve retornar no lado esquerno (Either) uma Failure', () async {
      when(() => repository.signUp(tRequestSignUpEntity()))
          .thenAnswer((_) async => Left<Failure, UserEntity>(tNoConnection()));

      final result = await signUpUseCase(tRequestSignUpEntity());

      expect(result, Left<Failure, UserEntity>(tNoConnection()));
    });
  });
}
