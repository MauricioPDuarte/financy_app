import 'package:financy_app/core/data/services/impl/session_service_impl.dart';
import 'package:financy_app/core/data/services/session_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_values.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SessionService sessionService;
  late FlutterSecureStorage secureStorage;
  late String userKey = 'user-session';

  setUp(() {
    secureStorage = MockFlutterSecureStorage();
    sessionService = SessionServiceImpl(flutterSecureStorage: secureStorage);
  });

  group('Test getLoggedUser()', () {
    test('Deve retornar um UserModel', () async {
      when(() => secureStorage.read(key: userKey))
          .thenAnswer((_) async => tUserModelJSON());

      final result = await sessionService.getLoggedUser();

      expect(result, tUserModel());
    });

    test('Deve retornar null', () async {
      when(() => secureStorage.read(key: userKey))
          .thenAnswer((_) async => null);

      final result = await sessionService.getLoggedUser();

      expect(result, isNull);
    });

    test('Deve retornar null ao estourar algum erro', () async {
      when(() => secureStorage.read(key: userKey)).thenThrow(Exception());

      final result = await sessionService.getLoggedUser();

      expect(result, isNull);
    });
  });

  group('Test setLoggedUser()', () {
    test('Deve retornar true', () async {
      when(() => secureStorage.write(key: userKey, value: tUserModelJSON()))
          .thenAnswer((_) async => Future.value());

      final result = await sessionService.setLoggedUser(tUserModel());

      expect(result, isTrue);
    });

    test('Deve retornar false', () async {
      when(() => secureStorage.write(key: userKey, value: tUserModelJSON()))
          .thenThrow(Exception());

      final result = await sessionService.setLoggedUser(tUserModel());

      expect(result, isFalse);
    });
  });

  group('Test destroyLoggedUser()', () {
    test('Deve retornar true quando existir alguma sessão para destruir',
        () async {
      when(() => secureStorage.containsKey(key: userKey))
          .thenAnswer((_) async => true);
      when(() => secureStorage.delete(key: userKey))
          .thenAnswer((_) async => Future.value());

      final result = await sessionService.destroyLoggedUser();

      expect(result, isTrue);
    });

    test('Deve retornar true quando não existir alguma sessão para destruir',
        () async {
      when(() => secureStorage.containsKey(key: userKey))
          .thenAnswer((_) async => false);
      when(() => secureStorage.delete(key: userKey))
          .thenAnswer((_) async => Future.value());

      final result = await sessionService.destroyLoggedUser();

      expect(result, isTrue);
    });

    test('Deve retornar false quando algum erro ocorrer', () async {
      when(() => secureStorage.containsKey(key: userKey))
          .thenThrow(Exception());

      final result = await sessionService.destroyLoggedUser();

      expect(result, isFalse);
    });
  });
}
