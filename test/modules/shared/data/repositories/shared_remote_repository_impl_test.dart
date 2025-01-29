import 'package:either_dart/either.dart';
import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/network_info.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_remote_datasource.dart';
import 'package:financy_app/modules/shared/data/repositories/shared_remote_repository_impl.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_remote_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockSharedRemoteDatasource extends Mock
    implements SharedRemoteDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NetworkInfo networkInfo;
  late SharedRemoteDatasource datasource;
  late SharedRemoteRepository repository;

  setUp(() {
    networkInfo = MockNetworkInfo();
    datasource = MockSharedRemoteDatasource();
    repository = SharedRemoteRepositoryImpl(
        datasource: datasource, networkInfo: networkInfo);
  });

  group('Test Function SignInWithFacebook', () {
    test('Deve retornar no lado direito (Either) um UserEntity', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => datasource.signInWithFacebook())
          .thenAnswer((_) async => tUserModel());

      final result = await repository.signInWithFacebook();

      expect(result, Right<Failure, UserEntity>(tUserModel()));
    });

    test('Deve retornar no lado esquerdo (Either) uma Failure', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => datasource.signInWithFacebook()).thenThrow(tApiFailure());

      final result = await repository.signInWithFacebook();

      expect(result, Left<Failure, UserModel>(tApiFailure()));
    });

    test(
        'Deve retornar no lado esquerdo (Either) uma Failure do tipo NoConnection',
        () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.signInWithFacebook();

      verifyNever(() => datasource.signInWithFacebook());

      expect(result, Left<Failure, UserModel>(tNoConnection()));
    });
  });

  group('Test Function SignInWithGoogle', () {
    test('Deve retornar no lado direito (Either) um UserEntity', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => datasource.signInWithGoogle())
          .thenAnswer((_) async => tUserModel());

      final result = await repository.signInWithGoogle();

      expect(result, Right<Failure, UserEntity>(tUserModel()));
    });

    test('Deve retornar no lado esquerdo (Either) uma Failure', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => datasource.signInWithGoogle()).thenThrow(tApiFailure());

      final result = await repository.signInWithGoogle();

      expect(result, Left<Failure, UserModel>(tApiFailure()));
    });

    test(
        'Deve retornar no lado esquerdo (Either) uma Failure do tipo NoConnection',
        () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.signInWithGoogle();

      verifyNever(() => datasource.signInWithGoogle());

      expect(result, Left<Failure, UserModel>(tNoConnection()));
    });
  });
}
