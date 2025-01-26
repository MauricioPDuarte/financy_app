import 'package:financy_app/core/data/services/auth_service.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_up/data/datasources/impl/sign_up_datasource_impl.dart';
import 'package:financy_app/modules/sign_up/data/datasources/sign_up_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_values.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late AuthService authService;
  late SignUpDatasource datasource;

  setUp(() {
    authService = MockAuthService();
    datasource = SignUpDatasourceImpl(authService: authService);
  });

  group('Test Function SignUp', () {
    test('Deve retornar a entidade UserModel', () async {
      when(() => authService.signUp(
            fullName: 'Mauricio Duarte',
            email: 'prussdev@gmail.com',
            password: 'Teste@123',
          )).thenAnswer((_) async => tUserModelWithId());

      final result = await datasource.signUp(tRequestSignUpModel());

      expect(result.id, '123123');
    });

    test('Deve retornar um erro do Tipo Failure', () async {
      when(() => authService.signUp(
            fullName: 'Mauricio Duarte',
            email: 'prussdev@gmail.com',
            password: 'Teste@123',
          )).thenThrow(SignUpFailure());

      expect(datasource.signUp(tRequestSignUpModel()),
          throwsA(isA<SignUpFailure>()));
    });
  });
}
