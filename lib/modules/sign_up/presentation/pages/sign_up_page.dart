import 'package:financy_app/core/utils/validator.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_bar_widget.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_button_widget.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_input_widget.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_social_button_widget.dart';
import 'package:financy_app/modules/sign_up/presentation/controllers/sign_up_controller.dart';
import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/core/ui/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController controller = Modular.get();

  Widget get _content => Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vamos começar',
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
              hint: 'Fulado da Silva',
              enabled: !controller.signUpIsLoading,
              label: 'Nome completo',
              keyboardType: TextInputType.name,
              validator: Validator.validateFullName,
            ),
            const SizedBox(height: 20),
            AppInputWidget(
              hint: 'exemplo@gmail.com',
              controller: controller.emailController,
              enabled: !controller.signUpIsLoading,
              keyboardType: TextInputType.emailAddress,
              label: 'Email',
              validator: Validator.validateEmail,
            ),
            const SizedBox(height: 20),
            AppInputWidget(
              controller: controller.passwordController,
              label: 'Senha',
              enabled: !controller.signUpIsLoading,
              keyboardType: TextInputType.visiblePassword,
              helperText:
                  'Deve conter 8 caracteres sendo 1 letra maiúscula e 1 número.',
              hint: '**********',
              isPassword: true,
              validator: Validator.validatePassword,
            ),
            const SizedBox(height: 20),
            AppInputWidget(
              label: 'Confirmar senha',
              keyboardType: TextInputType.visiblePassword,
              enabled: !controller.signUpIsLoading,
              hint: '**********',
              isPassword: true,
              validator: (value) => Validator.validateConfirmPassword(
                  value, controller.passwordController.text),
            ),
            const SizedBox(height: 18),
            AppButtonWidget(
              text: 'Cadastrar',
              loading: controller.signUpIsLoading,
              onPressed: () => controller.doSignUp(),
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
              enabled: !controller.signUpIsLoading,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            AppSocialButtonWidget(
              platform: SocialPlatforms.google,
              enabled: !controller.signUpIsLoading,
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
      body: AnimatedBuilder(
        animation: Listenable.merge([controller.signUpState]),
        builder: (_, __) => SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: _content,
            ),
          ),
        ),
      ),
    );
  }
}
