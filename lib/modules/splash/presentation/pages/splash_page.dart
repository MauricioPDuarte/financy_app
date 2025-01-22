import 'package:financy_app/theme/app_colors.dart';
import 'package:financy_app/theme/app_typography.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.greenGradient,
          ),
        ),
        child: Center(
          child: Text(
            'MyFinancy',
            style: AppTypography.bigText.apply(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
