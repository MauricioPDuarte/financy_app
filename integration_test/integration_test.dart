import 'package:either_dart/either.dart';
import 'package:financy_app/app_module.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_get_logged_user_usecase.dart';
import 'package:financy_app/modules/shared/shared_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import 'robots/robot_extension.dart';
import 'utils.dart';

class MockSharedGetLoggedUserUsecase extends Mock
    implements SharedGetLoggedUserUsecase {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late Widget aut;
  late SharedGetLoggedUserUsecase getLoggedUserUsecase;

  setUp(() async {
    aut = await const Utils().createAppUnderTest();
    getLoggedUserUsecase = MockSharedGetLoggedUserUsecase();
  });

  testWidgets('Onboarding Test', (WidgetTester tester) async {
    when(() => getLoggedUserUsecase.call(NoParams()))
        .thenAnswer((_) async => Right<Failure, UserEntity?>(null));

    Modular.init(AppModule());

    // Inicialize o app no teste
    await tester.pumpWidget(aut);

    Modular.bindModule(SharedModule());
    Modular.replaceInstance<SharedGetLoggedUserUsecase>(getLoggedUserUsecase);

    await tester.onboarding.processOnboarding();
  });
}
