import 'package:financy_app/modules/shared/presentation/widgets/app_bar_widget.dart';
import 'package:financy_app/modules/shared/shared_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockModule extends Mock implements Module {}

void main() {
  group('AppBarWidget Tests', () {
    testWidgets('Deve exibir o título quando fornecido', (tester) async {
      const title = 'Título de Teste';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBarWidget(title: title),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
    });
  });

  testWidgets('Não deve exibir o título se não fornecido', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBarWidget(),
        ),
      ),
    );

    expect(find.byType(Text), findsNothing);
  });

  testWidgets('Deve exibir o botão leading por padrão', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBarWidget(),
        ),
      ),
    );

    expect(find.byKey(SharedKeys.btnAppBarLending), findsOneWidget);
  });

  testWidgets('Não deve exibir o botão leading se showLeading for false',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBarWidget(showLeading: false),
        ),
      ),
    );

    expect(find.byKey(SharedKeys.btnAppBarLending), findsNothing);
  });
}
