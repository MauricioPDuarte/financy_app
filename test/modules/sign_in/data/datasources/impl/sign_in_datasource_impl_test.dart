import 'package:financy_app/core/data/services/auth_service.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_in/data/datasources/impl/sign_in_datasource_impl.dart';
import 'package:financy_app/modules/sign_in/data/datasources/sign_in_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_values.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late AuthService authService;
  late SignInDatasource datasource;

  setUp(() {
    authService = MockAuthService();
    datasource = SignInDatasourceImpl(authService: authService);
  });

  group('Test Function SignIn', () {
    test('Deve retornar a entidade UserModel', () async {
      when(() => authService.signIn(
            email: 'prussdev@gmail.com',
            password: 'Teste@123',
          )).thenAnswer((_) async => tUserModelWithId());

      final result = await datasource.signIn(tRequestSignInModel());

      expect(result.id, '123123');
    });

    test('Deve retornar um erro do Tipo Failure', () async {
      when(() => authService.signIn(
            email: 'prussdev@gmail.com',
            password: 'Teste@123',
          )).thenThrow(SignInFailure());

      expect(datasource.signIn(tRequestSignInModel()),
          throwsA(isA<SignInFailure>()));
    });
  });
}
