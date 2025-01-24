import 'package:financy_app/modules/shared/presentation/widgets/app_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  group('Test AppTextButtonWidget', () {
    const buttonTitle = 'Entrar';

    testWidgets('Renderizou com o título correto', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppTextButtonWidget(
              text: buttonTitle,
              onPressed: () {},
            ),
          ),
        ),
      ));

      expect(find.text(buttonTitle), findsOneWidget);
    });

    testWidgets('Respondeu ao pressionar', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppTextButtonWidget(
              text: buttonTitle,
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(TextButton));
      await tester.pump();

      expect(wasPressed, isTrue);
    });
  });
}
