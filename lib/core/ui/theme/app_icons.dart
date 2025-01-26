import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcons {
  static const String iconPath = 'assets/icons';
  static const String home = '$iconPath/home.svg';
  static const String alert = '$iconPath/alert.svg';
  static const String error = '$iconPath/error.svg';
}

extension AppIconsExt on String {
  AppIcon icon({
    String? icon,
    BoxFit? fit,
    Color? color,
    double? width,
    double? height,
    Function()? onTap,
  }) {
    return AppIcon(
      icon: this,
      fit: fit,
      color: color,
      width: width,
      height: height,
      onTap: onTap,
    );
  }

  AppIconString iconString({
    String? icon,
    BoxFit? fit,
    Color? color,
    double? width,
    double? height,
    Function()? onTap,
  }) {
    return AppIconString(
      icon: this,
      fit: fit,
      color: color,
      width: width,
      height: height,
      onTap: onTap,
    );
  }

  AppIconNetwork iconNetwork({
    String? icon,
    BoxFit? fit,
    Color? color,
    double? width,
    double? height,
    Function()? onTap,
  }) {
    return AppIconNetwork(
      icon: this,
      fit: fit,
      color: color,
      width: width,
      height: height,
      onTap: onTap,
    );
  }
}

class AppIcon extends StatelessWidget {
  final String? icon;
  final BoxFit? fit;
  final Color? color;
  final double? height;
  final double? width;
  final Function()? onTap;

  const AppIcon({
    super.key,
    this.icon,
    this.fit,
    this.color,
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height ?? 20,
        width: width ?? 20,
        child: SvgPicture.asset(
          icon ?? AppIcons.home,
          fit: fit ?? BoxFit.contain,
          colorFilter:
              color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
          width: width ?? 20,
          height: height ?? 20,
        ),
      ),
    );
  }
}

class AppIconString extends StatelessWidget {
  final String? icon;
  final BoxFit? fit;
  final Color? color;
  final double? height;
  final double? width;
  final Function()? onTap;

  const AppIconString({
    super.key,
    this.icon,
    this.fit,
    this.color,
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height ?? 20,
        width: width ?? 20,
        child: SvgPicture.string(
          icon ?? AppIcons.home,
          fit: fit ?? BoxFit.contain,
          colorFilter:
              color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
          width: width ?? 20,
          height: height ?? 20,
        ),
      ),
    );
  }
}

class AppIconNetwork extends StatelessWidget {
  final String? icon;
  final BoxFit? fit;
  final Color? color;
  final double? height;
  final double? width;
  final Function()? onTap;

  const AppIconNetwork({
    super.key,
    this.icon,
    this.fit,
    this.color,
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height ?? 20,
        width: width ?? 20,
        child: SvgPicture.network(
          icon ?? AppIcons.home,
          fit: fit ?? BoxFit.contain,
          colorFilter:
              color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
          width: width ?? 20,
          height: height ?? 20,
        ),
      ),
    );
  }
}
