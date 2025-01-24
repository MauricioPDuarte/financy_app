import 'package:financy_app/modules/shared/presentation/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFunction extends Mock {
  void teste();
}

void main() {
  group('Test AppButtonWidget', () {
    const buttonTitle = 'Quero começar agora';

    testWidgets('Deve renderizar com o título conforme esperado',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppButtonWidget(
            text: buttonTitle,
            onPressed: () {},
          ),
        ),
      ));

      expect(find.text(buttonTitle), findsOneWidget);
    });

    testWidgets('Deve responder ao pressionar o botão', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppButtonWidget(
                text: buttonTitle,
                onPressed: () {
                  wasPressed = true;
                }),
          ),
        ),
      ));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(wasPressed, isTrue);
    });

    testWidgets('Deve exibir o loading corretamente', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppButtonWidget(
              text: buttonTitle,
              loading: true,
              onPressed: () {},
            ),
          ),
        ),
      ));

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Deve bloquear o onPressed com o loading ativado',
        (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppButtonWidget(
                text: buttonTitle,
                loading: true,
                onPressed: () {
                  wasPressed = true;
                }),
          ),
        ),
      ));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(wasPressed, isFalse);
    });
  });
}
