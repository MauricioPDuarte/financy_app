import 'package:animate_do/animate_do.dart';
import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/core/ui/theme/app_typography.dart';
import 'package:financy_app/modules/splash/presentation/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController controller = Modular.get();

  @override
  void initState() {
    super.initState();

    controller.init();
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
