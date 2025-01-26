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

    testWidgets(
        'Deve renderizar o botão com opacidade reduzida quando desativado',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppButtonWidget(
            text: buttonTitle,
            enabled: false,
            onPressed: () {},
          ),
        ),
      ));

      final buttonFinder = find.byType(ElevatedButton);
      final buttonWidget = tester.widget<ElevatedButton>(buttonFinder);

      // Verificar se o botão está desativado
      expect(buttonWidget.onPressed, isNull);

      // Verificar opacidade
      final containerFinder = find.byType(Container);
      final containerWidget = tester.widget<Container>(containerFinder);
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(decoration.gradient?.colors, isNotNull);
      expect(decoration.gradient!.colors.first.a, equals(0.6));
    });

    testWidgets(
        'Deve exibir o gradiente com opacidade reduzida durante o loading',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppButtonWidget(
            text: buttonTitle,
            loading: true,
            onPressed: () {},
          ),
        ),
      ));

      // Verificar se o CircularProgressIndicator está presente
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Verificar opacidade do gradiente
      final containerFinder = find.byType(Container);
      final containerWidget = tester.widget<Container>(containerFinder);
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(decoration.gradient?.colors, isNotNull);
      expect(decoration.gradient!.colors.first.a, equals(0.6));
    });

    testWidgets(
        'Deve renderizar o texto com opacidade reduzida quando desativado',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppButtonWidget(
            text: buttonTitle,
            enabled: false,
            onPressed: () {},
          ),
        ),
      ));

      final textFinder = find.text(buttonTitle);
      final textWidget = tester.widget<Text>(textFinder);

      expect(textWidget.style?.color?.a, equals(0.6));
    });

    testWidgets(
        'Deve exibir corretamente o estado de loading e desativação juntos',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppButtonWidget(
            text: buttonTitle,
            loading: true,
            enabled: false,
            onPressed: () {},
          ),
        ),
      ));

      // Verificar se o CircularProgressIndicator está presente
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Verificar que onPressed está nulo
      final buttonFinder = find.byType(ElevatedButton);
      final buttonWidget = tester.widget<ElevatedButton>(buttonFinder);
      expect(buttonWidget.onPressed, isNull);
    });
  });
}
