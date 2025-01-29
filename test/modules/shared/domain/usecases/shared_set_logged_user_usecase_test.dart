import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_local_repository.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_set_logged_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockSharedLocalRepository extends Mock implements SharedLocalRepository {}

void main() {
  late SharedLocalRepository repository;
  late SharedSetLoggedUserUsecase setLoggedUserUsecase;

  setUp(() {
    repository = MockSharedLocalRepository();
    setLoggedUserUsecase =
        SharedSetLoggedUserUsecaseImpl(repository: repository);
  });

  test('Deve retornar no lado direito (Either) um valor true', () async {
    when(() => repository.setLoggedUser(tUserEntity()))
        .thenAnswer((_) async => Right<Failure, bool>(true));

    final result = await setLoggedUserUsecase(tUserEntity());

    expect(result, Right<Failure, bool>(true));
  });

  test('Deve retornar no lado direito (Either) um valor false', () async {
    when(() => repository.setLoggedUser(tUserEntity()))
        .thenAnswer((_) async => Right<Failure, bool>(false));

    final result = await setLoggedUserUsecase(tUserEntity());

    expect(result, Right<Failure, bool>(false));
  });

  test('Deve retornar no lado esquerdo (Either) uma failure', () async {
    when(() => repository.setLoggedUser(tUserEntity()))
        .thenAnswer((_) async => Left<Failure, bool>(tUnexpectedFailure()));

    final result = await setLoggedUserUsecase(tUserEntity());

    expect(result, Left<Failure, bool>(tUnexpectedFailure()));
  });
}
