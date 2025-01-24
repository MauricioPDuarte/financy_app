import 'package:financy_app/modules/onboarding/onboarding_keys.dart';
import 'package:financy_app/modules/onboarding/presentation/pages/onboarding_page.dart';
import 'package:financy_app/modules/shared/shared_keys.dart';
import 'package:financy_app/modules/sign_in/presentation/pages/sign_in_page.dart';
import 'package:financy_app/modules/sign_up/presentation/pages/sign_up_page.dart';
import 'package:financy_app/modules/splash/presentation/pages/splash_page.dart';
import 'package:flutter_test/flutter_test.dart';

import 'robot_extension.dart';

class OnboardingRobot {
  final WidgetTester tester;

  const OnboardingRobot(this.tester);

  Future<void> processOnboarding() async {
    // Procura a pagina de Splash
    final splashPage = find.byType(SplashPage);
    await tester.pumpUntilFound(tester, splashPage);
    expect(splashPage, findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 6));

    // Procura a pagina de Onboarding
    final onboardingPage = find.byType(OnboardingPage);
    await tester.pumpUntilFound(tester, onboardingPage);
    expect(onboardingPage, findsOneWidget);

    await findPageSignUpAndBackOnboading();
    await findPageSignInAndBackOnboading();
  }

  Future<void> findPageSignUpAndBackOnboading() async {
    // Tenta acessar a tela de cadastro
    final btnSignUp = find.byKey(OnboardingKeys.btnGetStartedSignUp);
    expect(btnSignUp, findsOneWidget);
    await tester.tap(btnSignUp);
    await tester.pumpAndSettle();

    // Procura a tela de cadastro
    final signUpPage = find.byType(SignUpPage);
    await tester.pumpUntilFound(tester, signUpPage);
    expect(signUpPage, findsOneWidget);

    // Tentar voltar para o onboarding
    final btnAppBarLending = find.byKey(SharedKeys.btnAppBarLending);
    expect(btnAppBarLending, findsOneWidget);
    await tester.tap(btnAppBarLending);
    await tester.pumpAndSettle();

    // Procura a pagina de Onboarding
    final backOnboardingPage = find.byType(OnboardingPage);
    await tester.pumpUntilFound(tester, backOnboardingPage);
    expect(backOnboardingPage, findsOneWidget);
  }

  Future<void> findPageSignInAndBackOnboading() async {
    // Tenta acessar a tela de login
    final btnSignIn = find.byKey(OnboardingKeys.btnSignIn);
    expect(btnSignIn, findsOneWidget);
    await tester.tap(btnSignIn);
    await tester.pumpAndSettle();

    // Procura a pagina de Login
    final signInPage = find.byType(SignInPage);
    await tester.pumpUntilFound(tester, signInPage);
    expect(signInPage, findsOneWidget);

    // Tentar voltar para o onboarding
    final btnAppBarLending = find.byKey(SharedKeys.btnAppBarLending);
    expect(btnAppBarLending, findsOneWidget);
    await tester.tap(btnAppBarLending);
    await tester.pumpAndSettle();

    // Procura a pagina de Onboarding
    final backOnboardingPage = find.byType(OnboardingPage);
    await tester.pumpUntilFound(tester, backOnboardingPage);
    expect(backOnboardingPage, findsOneWidget);
  }
}
