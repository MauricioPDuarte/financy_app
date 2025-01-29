import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_local_repository.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_get_logged_user_usecase.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_sign_in_with_facebook_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockSharedLocalRepository extends Mock implements SharedLocalRepository {}

void main() {
  late SharedLocalRepository repository;
  late SharedGetLoggedUserUsecase getLoggedUserUsecase;

  setUp(() {
    repository = MockSharedLocalRepository();
    getLoggedUserUsecase =
        SharedGetLoggedUserUsecaseImpl(repository: repository);
  });

  test('Deve retornar no lado direito (Either) um UserEntity', () async {
    when(() => repository.getLoggedUser())
        .thenAnswer((_) async => Right<Failure, UserEntity?>(tUserEntity()));

    final result = await getLoggedUserUsecase(NoParams());

    expect(result, Right<Failure, UserEntity?>(tUserEntity()));
  });

  test('Deve retornar no lado direito (Either) um valor null', () async {
    when(() => repository.getLoggedUser())
        .thenAnswer((_) async => Right<Failure, UserEntity?>(null));

    final result = await getLoggedUserUsecase(NoParams());

    expect(result, Right<Failure, UserEntity?>(null));
  });

  test('Deve retornar no lado esquerdo (Either) uma failure', () async {
    when(() => repository.getLoggedUser()).thenAnswer(
        (_) async => Left<Failure, UserEntity?>(tUnexpectedFailure()));

    final result = await getLoggedUserUsecase(NoParams());

    expect(result, Left<Failure, UserEntity?>(tUnexpectedFailure()));
  });
}
