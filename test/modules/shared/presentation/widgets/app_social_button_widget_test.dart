import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_social_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFunction extends Mock {
  void teste();
}

void main() {
  group('Test AppSocialButtonWidget', () {
    testWidgets('Deve renderizou com o visual Facebook', (tester) async {
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

    testWidgets('Deve renderizou com o visual Google', (tester) async {
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

    testWidgets('Deve responder ao pressionar o onPressed', (tester) async {
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

    testWidgets('Deve apresentar o loading corretamente', (tester) async {
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

    testWidgets('Deve ignorar o OnPresse quando o loading estiver ativo',
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

    testWidgets('Deve alterar o estilo quando desabilitado (Google)',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppSocialButtonWidget(
              platform: SocialPlatforms.google,
              enabled: false,
              onPressed: () {},
            ),
          ),
        ),
      ));

      final buttonFinder = find.byType(ElevatedButton);
      final buttonStyle = tester.widget<ElevatedButton>(buttonFinder).style;
      expect(buttonStyle?.backgroundColor?.resolve({WidgetState.disabled}),
          AppColors.inputBorderDisabled.withValues(alpha: 0.2));
    });

    testWidgets('Deve alterar o estilo quando desabilitado (Facebook)',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppSocialButtonWidget(
              platform: SocialPlatforms.facebook,
              enabled: false,
              onPressed: () {},
            ),
          ),
        ),
      ));

      final buttonFinder = find.byType(ElevatedButton);
      final buttonStyle = tester.widget<ElevatedButton>(buttonFinder).style;
      expect(buttonStyle?.backgroundColor?.resolve({WidgetState.disabled}),
          AppColors.facebook.withValues(alpha: 0.6));
    });
  });
}
