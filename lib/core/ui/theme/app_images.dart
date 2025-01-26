import 'package:flutter/material.dart';

class AppImages {
  static const _path = 'assets/images';

  // Social Platforms
  static const logoFacebook = '$_path/facebook.png';
  static const logoGoogle = '$_path/google.png';

  // Backgrounds
  static const background = '$_path/background.png';
}

extension AppImagesExt on String {
  Widget image({
    double? width,
    double? height,
    BoxFit? fit,
    VoidCallback? onTap,
    Animation<double>? opacity,
  }) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        this,
        width: width,
        opacity: opacity,
        height: height,
        fit: fit,
      ),
    );
  }
}
