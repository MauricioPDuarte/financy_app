import 'package:financy_app/modules/shared/shared_keys.dart';
import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/core/ui/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final String? title;

  const AppBarWidget({
    super.key,
    this.showLeading = true,
    this.title,
  });

  Widget get leadingWidget => Ink(
        padding: EdgeInsets.all(8),
        child: InkWell(
          key: SharedKeys.btnAppBarLending,
          borderRadius: BorderRadius.circular(80),
          onTap: () => Modular.to.pop(),
          child: Icon(Icons.arrow_back_outlined),
        ),
      );

  Widget get titleWidget => Text('Teste',
      style: AppTypography.inter600.copyWith(
        fontSize: 16,
        color: AppColors.text,
      ));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? titleWidget : null,
      centerTitle: true,
      forceMaterialTransparency: true,
      leading: showLeading ? leadingWidget : null,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 60);
}
