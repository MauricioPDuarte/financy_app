import 'package:financy_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppInputWidget extends StatefulWidget {
  final String? hint;
  final String? label;
  final bool isPassword;
  final TextEditingController? controller;

  const AppInputWidget(
      {super.key,
      this.hint,
      this.label,
      this.isPassword = false,
      this.controller});

  @override
  State<AppInputWidget> createState() => _AppInputWidgetState();
}

class _AppInputWidgetState extends State<AppInputWidget> {
  bool showText = true;

  TextEditingController? get controller => widget.controller;
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        label: widget.label != null ? Text(widget.label!) : null,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        fillColor: AppColors.backgroundInput,
        suffixIcon: isPassword ? iconEyePassword : null,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(14),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
