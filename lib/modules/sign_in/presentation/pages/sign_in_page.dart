import 'package:financy_app/modules/shared/presentation/widgets/app_bar_widget.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_button_widget.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_input_widget.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_social_button_widget.dart';
import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/core/ui/theme/app_typography.dart';
import 'package:financy_app/modules/sign_in/presentation/controllers/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInController controller = Modular.get();

  Widget get _content => Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Entrar',
                style: AppTypography.inter700.copyWith(
                  fontSize: 32,
                  color: AppColors.text,
                  height: 0,
                )),
            Text('Preencha seus dados abaixo',
                style: AppTypography.inter500.copyWith(
                  fontSize: 16,
                  height: 0,
                  color: AppColors.subtitle,
                )),
            const SizedBox(height: 32),
            AppInputWidget(
              hint: 'exemplo@gmail.com',
              enabled: !controller.signInIsLoading,
              controller: controller.emailController,
              label: 'Email',
            ),
            const SizedBox(height: 20),
            AppInputWidget(
              label: 'Senha',
              enabled: !controller.signInIsLoading,
              controller: controller.passwordController,
              hint: 'Digite sua senha',
              isPassword: true,
            ),
            const SizedBox(height: 18),
            AppButtonWidget(
              text: 'Entrar',
              loading: controller.signInIsLoading,
              onPressed: controller.signIn,
            ),
            const SizedBox(height: 18),
            Center(
              child: Text('Ou',
                  style: AppTypography.inter500.copyWith(
                    fontSize: 16,
                    height: 0,
                    color: AppColors.text,
                  )),
            ),
            const SizedBox(height: 18),
            AppSocialButtonWidget(
              platform: SocialPlatforms.facebook,
              enabled: !controller.signInIsLoading,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            AppSocialButtonWidget(
              platform: SocialPlatforms.google,
              enabled: !controller.signInIsLoading,
              onPressed: () {},
            ),
            const SizedBox(height: 18),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTypography.inter400
                    .copyWith(fontSize: 13, color: AppColors.subtitle),
                children: [
                  TextSpan(
                    text: 'Ao realizar o login, você aceita os ',
                  ),
                  TextSpan(
                      text: 'Termos de Uso', style: AppTypography.inter600),
                  TextSpan(
                    text: ' e ',
                  ),
                  TextSpan(
                      text: 'Políticas de Privacidade',
                      style: AppTypography.inter600),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: AnimatedBuilder(
                animation: Listenable.merge([controller.signInState]),
                builder: (_, __) => _content,
              )),
        ),
      ),
    );
  }
}
