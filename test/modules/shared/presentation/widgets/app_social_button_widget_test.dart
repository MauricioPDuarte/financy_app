import 'package:financy_app/modules/shared/presentation/widgets/app_social_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFunction extends Mock {
  void teste();
}

void main() {
  group('Test AppSocialButtonWidget', () {
    testWidgets('Renderizou como Facebook', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppSocialButtonWidget(
            platform: SocialPlatforms.facebook,
            onPressed: () {},
          ),
        ),
      ));

      expect(find.text('Entrar com Facebook'), findsOneWidget);
    });

    testWidgets('Renderizou como Google', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppSocialButtonWidget(
            platform: SocialPlatforms.google,
            onPressed: () {},
          ),
        ),
      ));

      expect(find.text('Entrar com Google'), findsOneWidget);
    });

    testWidgets('Respondeu ao pressionar', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppSocialButtonWidget(
                platform: SocialPlatforms.google,
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

    testWidgets('Loading está aparecendo', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppSocialButtonWidget(
              loading: true,
              platform: SocialPlatforms.google,
              onPressed: () {},
            ),
          ),
        ),
      ));

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('OnPressed não pode ser chamado com loading ativado',
        (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppSocialButtonWidget(
                platform: SocialPlatforms.google,
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
