import 'package:financy_app/core/ui/theme/app_icons.dart';
import 'package:financy_app/core/ui/utils/app_dialogs.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_test/flutter_svg_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Deve exibir o bottom sheet com título, mensagem e botão',
      (tester) async {
    // Define o contexto para o teste
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          body: ElevatedButton(
            onPressed: () {
              AppDialogs.bottomSheetError(
                buildContext: context,
                title: 'Erro',
                message: 'Algo deu errado',
              );
            },
            child: Text('Abrir BottomSheet'),
          ),
        );
      }),
    ));

    // Aciona o botão para abrir o bottom sheet
    await tester.tap(find.text('Abrir BottomSheet'));
    await tester.pumpAndSettle();

    // Verifica se os elementos principais estão presentes
    expect(find.text('Erro'), findsOneWidget);
    expect(find.text('Algo deu errado'), findsOneWidget);
    expect(find.byType(AppButtonWidget), findsOneWidget);
  });

  testWidgets('Deve executar onTap ao pressionar o botão', (tester) async {
    bool onPressed = false;

    // Define o contexto para o teste
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          body: ElevatedButton(
            onPressed: () {
              AppDialogs.bottomSheetError(
                  buildContext: context,
                  title: 'Erro',
                  message: 'Algo deu errado',
                  onTap: () {
                    onPressed = true;
                  });
            },
            child: Text('Abrir BottomSheet'),
          ),
        );
      }),
    ));

    // Aciona o botão para abrir o bottom sheet
    await tester.tap(find.text('Abrir BottomSheet'));
    await tester.pumpAndSettle();

    // Aciona o botão para fechar o bottom sheet
    await tester.tap(find.text('Fechar'));
    await tester.pumpAndSettle();

    expect(onPressed, isTrue);
  });

  testWidgets('Deve exibir o ícone padrão quando nenhum ícone for fornecido',
      (tester) async {
    // Define o contexto para o teste
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          body: ElevatedButton(
            onPressed: () {
              AppDialogs.bottomSheetError(
                buildContext: context,
                title: 'Erro',
                message: 'Algo deu errado',
              );
            },
            child: Text('Abrir BottomSheet'),
          ),
        );
      }),
    ));

    // Aciona o botão para abrir o diálogo
    await tester.tap(find.text('Abrir BottomSheet'));
    await tester.pumpAndSettle();

    expect(find.svgAssetWithPath(AppIcons.error), findsOneWidget);
  });

  testWidgets('Deve exibir o ícone customizado quando for fornecido',
      (tester) async {
    // Define o contexto para o teste
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          body: ElevatedButton(
            onPressed: () {
              AppDialogs.bottomSheetError(
                buildContext: context,
                title: 'Erro',
                message: 'Algo deu errado',
                icon: AppIcons.home.icon(),
              );
            },
            child: Text('Abrir BottomSheet'),
          ),
        );
      }),
    ));

    // Aciona o botão para abrir o diálogo
    await tester.tap(find.text('Abrir BottomSheet'));
    await tester.pumpAndSettle();

    expect(find.svgAssetWithPath(AppIcons.home), findsOneWidget);
  });
}
