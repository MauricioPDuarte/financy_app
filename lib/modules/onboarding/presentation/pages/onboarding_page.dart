import 'package:financy_app/modules/onboarding/onboarding_keys.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_button_widget.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_text_button_widget.dart';
import 'package:financy_app/modules/sign_in/sign_in_routes.dart';
import 'package:financy_app/modules/sign_up/sign_up_routes.dart';
import 'package:financy_app/theme/app_colors.dart';
import 'package:financy_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'VISIS',
                  style: AppTypography.inter900.copyWith(
                      color: AppColors.white,
                      letterSpacing: 4,
                      height: 0,
                      fontSize: 32),
                ),
                Spacer(),
                Column(
                  spacing: 22,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTypography.inter400.copyWith(
                            fontSize: 35, color: AppColors.white, height: 1.2),
                        children: [
                          TextSpan(
                            text: 'Cuidar do dinheiro em',
                          ),
                          TextSpan(
                              text: ' conjunto ',
                              style: AppTypography.inter600),
                          TextSpan(
                            text: 'fica muito mais fácil!',
                          ),
                        ],
                      ),
                    ),
                    AppButtonWidget(
                        key: OnboardingKeys.btnGetStartedSignUp,
                        text: 'Quero começar agora',
                        onPressed: () =>
                            Modular.to.pushNamed(SignUpRoutes.signUp)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          'Já tem sua conta?',
                          style: AppTypography.inter500
                              .copyWith(color: AppColors.white, fontSize: 14),
                        ),
                        AppTextButtonWidget(
                          key: OnboardingKeys.btnSignIn,
                          text: 'Entrar',
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          onPressed: () =>
                              Modular.to.pushNamed(SignInRoutes.signIn),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
