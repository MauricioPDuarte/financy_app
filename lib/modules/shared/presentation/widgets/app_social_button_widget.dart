import 'package:financy_app/theme/app_colors.dart';
import 'package:financy_app/theme/app_images.dart';
import 'package:financy_app/theme/app_typography.dart';
import 'package:flutter/material.dart';

enum SocialPlatforms { facebook, google }

class AppSocialButtonWidget extends StatelessWidget {
  final SocialPlatforms platform;
  final VoidCallback onPressed;
  final bool loading;

  const AppSocialButtonWidget({
    super.key,
    required this.platform,
    required this.onPressed,
    this.loading = false,
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
        return AppColors.white;
      case SocialPlatforms.google:
        return AppColors.text;
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
        getPathImageByPlatformSocial.image(width: 24, height: 24),
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
        backgroundColor: getBackgroundColorByPlatformSocial,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: getBorderColorByPlatformSocial),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: !loading ? onPressed : null,
      child: loading ? loadingWidget : contentButton,
    );
  }
}
