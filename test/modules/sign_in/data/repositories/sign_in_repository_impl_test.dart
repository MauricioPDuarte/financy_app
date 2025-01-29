import 'package:either_dart/either.dart';
import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/network_info.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_in/data/datasources/sign_in_datasource.dart';
import 'package:financy_app/modules/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:financy_app/modules/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockSignInDatasource extends Mock implements SignInDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NetworkInfo networkInfo;
  late SignInDatasource datasource;
  late SignInRepository repository;

  setUp(() {
    networkInfo = MockNetworkInfo();
    datasource = MockSignInDatasource();
    repository =
        SignInRepositoryImpl(datasource: datasource, networkInfo: networkInfo);
  });

  group('Test Function SignIn', () {
    test('Deve retornar no lado direito (Either) um UserEntity', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => datasource.signIn(tRequestSignInModel()))
          .thenAnswer((_) async => tUserModel());

      final result = await repository.signIn(tRequestSignInModel());

      expect(result, Right<Failure, UserEntity>(tUserModel()));
    });

    test('Deve retornar no lado esquerdo (Either) uma Failure', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => datasource.signIn(tRequestSignInModel()))
          .thenThrow(tApiFailure());

      final result = await repository.signIn(tRequestSignInModel());

      expect(result, Left<Failure, UserModel>(tApiFailure()));
    });

    test(
        'Deve retornar no lado esquerdo (Either) uma Failure do tipo NoConnection',
        () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.signIn(tRequestSignInModel());

      verifyNever(() => datasource.signIn(tRequestSignInModel()));

      expect(result, Left<Failure, UserModel>(tNoConnection()));
    });
  });
}
