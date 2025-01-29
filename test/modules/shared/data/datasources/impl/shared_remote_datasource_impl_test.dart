import 'package:financy_app/core/data/services/auth_service.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/shared/data/datasouces/impl/shared_remote_datasource_impl.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_values.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late AuthService authService;
  late SharedRemoteDatasource datasource;

  setUp(() {
    authService = MockAuthService();
    datasource = SharedRemoteDatasourceImpl(authService: authService);
  });

  group('Test Function signInWithFacebook', () {
    test('Deve retornar a entidade UserModel', () async {
      when(() => authService.signInWithFacebook())
          .thenAnswer((_) async => tUserModelWithId());

      final result = await datasource.signInWithFacebook();

      expect(result.id, '123123');
    });

    test('Deve retornar um erro do Tipo Failure', () async {
      when(() => authService.signInWithFacebook()).thenThrow(SignInFailure());

      expect(datasource.signInWithFacebook(), throwsA(isA<SignInFailure>()));
    });
  });

  group('Test Function signInWithGoogle', () {
    test('Deve retornar a entidade UserModel', () async {
      when(() => authService.signInWithGoogle())
          .thenAnswer((_) async => tUserModelWithId());

      final result = await datasource.signInWithGoogle();

      expect(result.id, '123123');
    });

    test('Deve retornar um erro do Tipo Failure', () async {
      when(() => authService.signInWithGoogle()).thenThrow(SignInFailure());

      expect(datasource.signInWithGoogle(), throwsA(isA<SignInFailure>()));
    });
  });
}
