import 'package:either_dart/either.dart';
import 'package:financy_app/core/data/services/network_info.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_local_datasource.dart';
import 'package:financy_app/modules/shared/data/repositories/shared_local_repository_impl.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_local_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockSharedLocalDatasource extends Mock implements SharedLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late SharedLocalDatasource datasource;
  late SharedLocalRepository repository;

  setUp(() {
    datasource = MockSharedLocalDatasource();
    repository = SharedLocalRepositoryImpl(datasource: datasource);
  });

  group('Test Function doLogout()', () {
    test('Deve retornar no lado direito (Either) o valor true', () async {
      when(() => datasource.doLogout()).thenAnswer((_) async => true);

      final result = await repository.doLogout();

      expect(result, Right<Failure, bool>(true));
    });

    test('Deve retornar no lado direito (Either) o valor false', () async {
      when(() => datasource.doLogout()).thenAnswer((_) async => false);

      final result = await repository.doLogout();

      expect(result, Right<Failure, bool>(false));
    });
  });

  group('Test Function getLoggedUser()', () {
    test('Deve retornar no lado direito (Either) um UserModel', () async {
      when(() => datasource.getLoggedUser())
          .thenAnswer((_) async => tUserModel());

      final result = await repository.getLoggedUser();

      expect(result, Right<Failure, UserEntity>(tUserModel()));
    });

    test('Deve retornar no lado direito (Either) um null', () async {
      when(() => datasource.getLoggedUser()).thenAnswer((_) async => null);

      final result = await repository.getLoggedUser();

      expect(result, Right<Failure, UserEntity?>(null));
    });
  });

  group('Test Function setLoggedUser()', () {
    test('Deve retornar no lado direito (Either) o valor true', () async {
      when(() => datasource.setLoggedUser(tUserModel()))
          .thenAnswer((_) async => true);

      final result = await repository.setLoggedUser(tUserModel());

      expect(result, Right<Failure, bool>(true));
    });

    test('Deve retornar no lado direito (Either) o valor false', () async {
      when(() => datasource.setLoggedUser(tUserModel()))
          .thenAnswer((_) async => false);

      final result = await repository.setLoggedUser(tUserModel());

      expect(result, Right<Failure, bool>(false));
    });
  });
}
