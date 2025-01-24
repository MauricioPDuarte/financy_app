import 'package:financy_app/theme/app_colors.dart';
import 'package:financy_app/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;

  const AppButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
  });

  Widget get loadingWidget => SizedBox(
      width: 22,
      height: 22,
      child: CircularProgressIndicator(
        color: AppColors.white,
        strokeWidth: 1,
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: AppColors.buttonGradient)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 58),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: !loading ? onPressed : null,
        child: loading
            ? loadingWidget
            : Text(text,
                style: AppTypography.inter600
                    .copyWith(color: AppColors.white, fontSize: 16)),
      ),
    );
  }
}
