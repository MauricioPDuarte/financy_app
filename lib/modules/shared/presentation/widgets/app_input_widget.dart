import 'package:financy_app/core/ui/theme/app_colors.dart';
import 'package:financy_app/core/ui/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputWidget extends StatefulWidget {
  final String? hint;
  final String? label;
  final bool isPassword;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final String? helperText;

  const AppInputWidget({
    super.key,
    this.hint,
    this.label,
    this.isPassword = false,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.keyboardType,
    this.enabled = true,
    this.helperText,
  });

  @override
  State<AppInputWidget> createState() => _AppInputWidgetState();
}

class _AppInputWidgetState extends State<AppInputWidget> {
  bool showText = true;

  String? get label => widget.label;
  String? get hint => widget.hint;
  String? get helperText => widget.helperText;
  String? Function(String?)? get validator => widget.validator;
  TextInputType? get keyboardType => widget.keyboardType;
  List<TextInputFormatter>? get inputFormatters => widget.inputFormatters;
  TextEditingController? get controller => widget.controller;
  bool get enabled => widget.enabled;
  bool get isPassword => widget.isPassword;
  bool get obscureText => isPassword && !showText;

  @override
  void initState() {
    super.initState();

    if (isPassword) changeShowText();
  }

  void changeShowText() {
    setState(() => showText = !showText);
  }

  Widget get iconEyePassword => GestureDetector(
      key: const Key('action-visibility-password'),
      onTap: changeShowText,
      child: showText ? Icon(Icons.visibility) : Icon(Icons.visibility_off));

  InputBorder get defaultBorder => OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(14),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      enabled: enabled,
      validator: validator,
      decoration: InputDecoration(
        errorMaxLines: 3,
        helperMaxLines: 3,
        helperText: helperText,
        helperStyle: AppTypography.inter400
            .copyWith(fontSize: 12, color: AppColors.subtitle),
        hintText: hint,
        label: label != null ? Text(label!) : null,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        fillColor: AppColors.backgroundInput,
        suffixIcon: isPassword ? iconEyePassword : null,
        filled: true,
        errorStyle: AppTypography.inter500.copyWith(color: AppColors.textError),
        disabledBorder: defaultBorder.copyWith(
            borderSide: BorderSide(color: AppColors.inputBorderDisabled)),
        focusedBorder: defaultBorder.copyWith(
            borderSide: BorderSide(color: AppColors.primary)),
        errorBorder: defaultBorder.copyWith(
            borderSide: BorderSide(color: AppColors.inputBorderError)),
        enabledBorder: defaultBorder,
        border: defaultBorder,
      ),
    );
  }
}
