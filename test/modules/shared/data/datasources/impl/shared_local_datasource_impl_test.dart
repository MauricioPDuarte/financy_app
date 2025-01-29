import 'package:financy_app/core/data/services/session_service.dart';
import 'package:financy_app/modules/shared/data/datasouces/impl/shared_local_datasource_impl.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_values.dart';

class MockSessionService extends Mock implements SessionService {}

void main() {
  late SessionService sessionService;
  late SharedLocalDatasource datasource;

  setUp(() {
    sessionService = MockSessionService();
    datasource = SharedLocalDatasourceImpl(sessionService: sessionService);
  });

  group('Test Function doLogout()', () {
    test('Deve retornar true indicando sucesso', () async {
      when(() => sessionService.destroyLoggedUser())
          .thenAnswer((_) async => true);

      final result = await datasource.doLogout();

      expect(result, isTrue);
    });

    test('Deve retornar false indicando que ocorreu um erro', () async {
      when(() => sessionService.destroyLoggedUser())
          .thenAnswer((_) async => false);

      final result = await datasource.doLogout();

      expect(result, isFalse);
    });
  });

  group('Test Function getLoggedUser()', () {
    test('Deve retornar a entidade UserModel', () async {
      when(() => sessionService.getLoggedUser())
          .thenAnswer((_) async => tUserModelWithId());

      final result = await datasource.getLoggedUser();

      expect(result?.id, '123123');
    });

    test('Deve retornar null', () async {
      when(() => sessionService.getLoggedUser()).thenAnswer((_) async => null);

      final result = await datasource.getLoggedUser();

      expect(result, isNull);
    });
  });

  group('Test Function setLoggedUser()', () {
    test('Deve retornar true', () async {
      when(() => sessionService.setLoggedUser(tUserModel()))
          .thenAnswer((_) async => true);

      final result = await datasource.setLoggedUser(tUserModel());

      expect(result, true);
    });

    test('Deve retornar false indicando que ocorreu um erro', () async {
      when(() => sessionService.setLoggedUser(tUserModel()))
          .thenAnswer((_) async => false);

      final result = await datasource.setLoggedUser(tUserModel());

      expect(result, false);
    });
  });
}
