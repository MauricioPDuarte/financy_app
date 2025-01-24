import 'package:animate_do/animate_do.dart';
import 'package:financy_app/modules/onboarding/onboarding_routes.dart';
import 'package:financy_app/theme/app_colors.dart';
import 'package:financy_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5)).then(
        (_) => Modular.to.pushReplacementNamed(OnboardingRoutes.onboarding));
  }

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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ZoomIn(
              child: Text(
                'VISIS',
                style: AppTypography.inter900.copyWith(
                  color: AppColors.white,
                  fontSize: 50,
                  letterSpacing: 4,
                  height: 0,
                ),
              ),
            ),
            FadeIn(
              child: Text(
                'Juntos vocês crescem',
                style: AppTypography.inter300.copyWith(
                  color: AppColors.white,
                  height: 0,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
