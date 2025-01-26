import 'package:financy_app/app_widget.dart';
import 'package:financy_app/modules/shared/presentation/widgets/app_button_widget.dart';
import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/core/ui/theme/app_icons.dart';
import 'package:financy_app/core/ui/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppDialogs {
  static void bottomSheetError({
    BuildContext? buildContext,
    AppIcon? icon,
    required String title,
    required String message,
    Function()? onTap,
    String? btnLabel,
  }) {
    final context = buildContext ?? AppGlobalKeys.navigatorKey.currentContext;
    if (context == null) {
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      isDismissible: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon ?? AppIcons.error.icon(width: 36, height: 36),
                    Text(title,
                        style: AppTypography.inter800
                            .copyWith(fontSize: 22, color: AppColors.text)),
                    const SizedBox(height: 8),
                    Text(message,
                        textAlign: TextAlign.center,
                        style: AppTypography.inter400
                            .copyWith(color: AppColors.subtitle)),
                    const SizedBox(height: 24),
                    AppButtonWidget(
                      onPressed: onTap ?? () => Modular.to.pop(),
                      text: btnLabel ?? 'Fechar',
                    )
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
