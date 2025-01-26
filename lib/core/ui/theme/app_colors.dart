import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static Color white = const Color(0xffffffff);
  static Color secondary = const Color(0xff456EFE);
  static Color primary = const Color(0xff244DDC);

  static Color text = const Color(0xff2B2B2B);
  static Color subtitle = const Color(0xff7A7A7A);

  static Color facebook = const Color(0xff3B5998);
  static Color google = const Color(0xffFFFFFF);

  static Color backgroundInput = const Color(0xffF0F0F0);
  static Color inputBorderError = const Color(0xFFF44336);
  static Color inputBorderDisabled = const Color(0xFFA4A9AE);
  static Color textError = const Color(0xFFF44336);

  static Color borderButton = const Color(0xffB0B0B0);

  static List<Color> buttonGradient = <Color>[
    AppColors.secondary,
    AppColors.primary,
  ];
}
