import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/core/ui/theme/app_images.dart';
import 'package:financy_app/core/ui/theme/app_typography.dart';
import 'package:flutter/material.dart';

enum SocialPlatforms { facebook, google }

class AppSocialButtonWidget extends StatelessWidget {
  final SocialPlatforms platform;
  final VoidCallback onPressed;
  final bool loading;
  final bool enabled;

  const AppSocialButtonWidget({
    super.key,
    required this.platform,
    required this.onPressed,
    this.loading = false,
    this.enabled = true,
  });

  String get getPathImageByPlatformSocial {
    switch (platform) {
      case SocialPlatforms.facebook:
        return AppImages.logoFacebook;
      case SocialPlatforms.google:
        return AppImages.logoGoogle;
    }
  }

  String get getTextByPlatformSocial {
    switch (platform) {
      case SocialPlatforms.facebook:
        return 'Facebook';
      case SocialPlatforms.google:
        return 'Google';
    }
  }

  Color get getBackgroundColorByPlatformSocial {
    switch (platform) {
      case SocialPlatforms.facebook:
        return AppColors.facebook;
      case SocialPlatforms.google:
        return AppColors.google;
    }
  }

  Color get getBorderColorByPlatformSocial {
    switch (platform) {
      case SocialPlatforms.facebook:
        return Colors.transparent;
      case SocialPlatforms.google:
        return AppColors.borderButton;
    }
  }

  Color get getTextColorByPlatformSocial {
    switch (platform) {
      case SocialPlatforms.facebook:
        return enabled
            ? AppColors.white
            : AppColors.white.withValues(alpha: 0.6);
      case SocialPlatforms.google:
        return enabled ? AppColors.text : AppColors.text.withValues(alpha: 0.6);
    }
  }

  Color get getBackgroundDisabledByPlatformSocial {
    switch (platform) {
      case SocialPlatforms.facebook:
        return AppColors.facebook.withValues(alpha: 0.6);
      case SocialPlatforms.google:
        return AppColors.inputBorderDisabled.withValues(alpha: 0.2);
    }
  }

  Widget get loadingWidget => SizedBox(
      width: 22,
      height: 22,
      child: CircularProgressIndicator(
        color: getTextColorByPlatformSocial,
        strokeWidth: 1,
      ));

  Widget get contentButton {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPathImageByPlatformSocial.image(
            width: 24,
            height: 24,
            opacity: enabled
                ? AlwaysStoppedAnimation<double>(1)
                : AlwaysStoppedAnimation<double>(0.6)),
        Text(
          'Entrar com $getTextByPlatformSocial',
          style: AppTypography.inter500.copyWith(
            fontSize: 16,
            color: getTextColorByPlatformSocial,
          ),
        ),
        Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 58),
        disabledBackgroundColor: getBackgroundDisabledByPlatformSocial,
        backgroundColor: getBackgroundColorByPlatformSocial,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: getBorderColorByPlatformSocial),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: !loading && enabled ? onPressed : null,
      child: loading ? loadingWidget : contentButton,
    );
  }
}
