import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test AppButtonWidget', () {
    testWidgets('Deve exibir o hintText corretamente', (tester) async {
      const hintText = 'Digite algo';
      const label = 'Email';

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
              child: AppInputWidget(
            hint: hintText,
            label: label,
          )),
        ),
      ));

      expect(find.text(hintText), findsOneWidget);
    });

    testWidgets('Deve exibir o label corretamente quando tem foco',
        (tester) async {
      const labelText = 'Email';
      final controller = TextEditingController();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SafeArea(
              child: AppInputWidget(
            controller: controller,
            label: labelText,
          )),
        ),
      ));

      expect(find.text(labelText), findsOneWidget);
    });

    testWidgets('Deve permitir entrada de texto', (tester) async {
      const hintText = 'Digite algo';
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SafeArea(
                child: AppInputWidget(hint: hintText, controller: controller)),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Teste Flutter');

      expect(controller.text, 'Teste Flutter');
    });

    testWidgets(
        'Deve exibir o ícone visibilidade correto para obscureText ativo e inativo',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SafeArea(
                child: AppInputWidget(
              isPassword: true,
            )),
          ),
        ),
      );

      // Busca o icone Visibility OFF (Senha não aparece)
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsNothing);
      expect(
          tester.widget<TextField>(find.byType(TextField)).obscureText, isTrue);

      // Clica no icone Visibility (Gesture Detector)
      await tester.tap(find.byKey(const Key('action-visibility-password')));
      await tester.pumpAndSettle();

      // Busca o icone Visibility (Senha aparecendo)
      expect(find.byIcon(Icons.visibility_off), findsNothing);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(tester.widget<TextField>(find.byType(TextField)).obscureText,
          isFalse);
    });

    testWidgets('Deve exibir o texto quando não for uma senha', (tester) async {
      const hintText = 'Digite algo';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SafeArea(
                child: AppInputWidget(
              hint: hintText,
              isPassword: false,
            )),
          ),
        ),
      );

      // Busca o input
      var inputFinder = find.byType(TextField);
      final inputWidget = tester.widget<TextField>(inputFinder);
      await tester.enterText(inputFinder, 'senha');
      expect(inputWidget.obscureText, isFalse);

      // Busca icones de visibility
      var iconVisibility = find.byIcon(Icons.visibility);
      var iconVisibilityOff = find.byIcon(Icons.visibility_off);
      expect(iconVisibility, findsNothing);
      expect(iconVisibilityOff, findsNothing);
    });
  });

  testWidgets('Deve exibir erro quando a validação falhar', (tester) async {
    const errorMessage = 'Campo obrigatório';
    var formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: AppInputWidget(
                validator: (value) =>
                    value == null || value.isEmpty ? errorMessage : null,
              ),
            ),
          ),
        ),
      ),
    );

    // Aciona a validação
    await tester.enterText(find.byType(TextFormField), '');
    formKey.currentState?.validate();
    await tester.pumpAndSettle();

    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('Deve aplicar os inputFormatters corretamente', (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppInputWidget(
              controller: controller,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'abc123');
    expect(controller.text, '123');
  });

  testWidgets('Deve desativar o campo quando enabled for false',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppInputWidget(
              enabled: false,
              hint: 'Desabilitado',
            ),
          ),
        ),
      ),
    );

    final textField = find.byType(TextField);
    expect(tester.widget<TextField>(textField).enabled, isFalse);

    await tester.enterText(textField, 'Texto');
    expect(find.text('Texto'), findsNothing); // Não insere texto
  });

  testWidgets('Deve exibir o helperText corretamente', (tester) async {
    const helperText = 'Isso é um texto de ajuda';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppInputWidget(
              helperText: helperText,
            ),
          ),
        ),
      ),
    );

    expect(find.text(helperText), findsOneWidget);
  });

  testWidgets('Deve aplicar a borda correta ao ganhar foco', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AppInputWidget(
              hint: 'Teste borda',
            ),
          ),
        ),
      ),
    );

    final textField = find.byType(TextField);
    await tester.tap(textField);
    await tester.pumpAndSettle();

    final inputDecoration = tester.widget<TextField>(textField).decoration;
    expect(inputDecoration?.focusedBorder?.borderSide.color, AppColors.primary);
  });
}
