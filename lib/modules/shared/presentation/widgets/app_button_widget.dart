import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/core/ui/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  final bool enabled;

  const AppButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.enabled = true,
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
          colors: AppColors.buttonGradient,
        ).withOpacity(loading || !enabled ? 0.6 : 1),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 58),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: !loading && enabled ? onPressed : null,
        child: loading
            ? loadingWidget
            : Text(text,
                style: AppTypography.inter600.copyWith(
                    color: AppColors.white.withValues(alpha: enabled ? 1 : 0.6),
                    fontSize: 16)),
      ),
    );
  }
}
