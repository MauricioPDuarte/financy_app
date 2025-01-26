import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/core/ui/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppTextButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;

  const AppTextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: padding,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTypography.inter600
              .copyWith(color: AppColors.primary, fontSize: 14),
        ));
  }
}
