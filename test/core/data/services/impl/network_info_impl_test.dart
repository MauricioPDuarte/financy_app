import 'package:financy_app/core/data/services/impl/network_info_impl.dart';
import 'package:financy_app/core/data/services/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late MockInternetConnectionChecker internetConnectionChecker;
  late NetworkInfo networkInfo;

  setUp(() {
    internetConnectionChecker = MockInternetConnectionChecker();
    networkInfo =
        NetworkInfoImpl(internetConnectionChecker: internetConnectionChecker);
  });

  test('Deve retornar um true se houver conexão', () async {
    when(() => internetConnectionChecker.hasConnection)
        .thenAnswer((_) async => true);

    final result = await networkInfo.isConnected;

    expect(result, isTrue);
  });

  test('Deve retornar um false se não houver conexão', () async {
    when(() => internetConnectionChecker.hasConnection)
        .thenAnswer((_) async => false);

    final result = await networkInfo.isConnected;

    expect(result, isFalse);
  });
}
