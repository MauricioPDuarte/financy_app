import 'package:either_dart/either.dart';
import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/network_info.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_up/data/datasources/sign_up_datasource.dart';
import 'package:financy_app/modules/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:financy_app/modules/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockSignUpDatasource extends Mock implements SignUpDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NetworkInfo networkInfo;
  late SignUpDatasource datasource;
  late SignUpRepository repository;

  setUp(() {
    networkInfo = MockNetworkInfo();
    datasource = MockSignUpDatasource();
    repository =
        SignUpRepositoryImpl(datasource: datasource, networkInfo: networkInfo);
  });

  group('Test Function SignUp', () {
    test('Deve retornar no lado direito (Either) um UserEntity', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => datasource.signUp(tRequestSignUpModel()))
          .thenAnswer((_) async => tUserModel());

      final result = await repository.signUp(tRequestSignUpModel());

      expect(result, Right<Failure, UserEntity>(tUserModel()));
    });

    test('Deve retornar no lado esquerdo (Either) uma Failure', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => datasource.signUp(tRequestSignUpModel()))
          .thenThrow(tApiFailure());

      final result = await repository.signUp(tRequestSignUpModel());

      expect(result, Left<Failure, UserModel>(tApiFailure()));
    });

    test(
        'Deve retornar no lado esquerdo (Either) uma Failure do tipo NoConnection',
        () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.signUp(tRequestSignUpModel());

      verifyNever(() => datasource.signUp(tRequestSignUpModel()));

      expect(result, Left<Failure, UserModel>(tNoConnection()));
    });
  });
}
