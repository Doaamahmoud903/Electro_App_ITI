import 'package:electro/core/functions/custom_outlined_border.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    this.isPassword,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.maxLines,
    this.inputFormatters,
    this.onChanged,
    this.hintStyle,
    super.key,
    this.suffixIcon,
    this.suffix,
    this.suffixText,
  });

  final String hintText;
  final String? suffixText;
  final TextEditingController? controller;
  final Widget? prefixIcon, suffixIcon, suffix;
  final bool? isPassword;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword ?? false,
      controller: controller,
      validator: validator,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 50,
          maxWidth: 50,
        ),
        hintText: hintText,
        prefixIconColor: ColorsManager.textColor,
        hintStyle:
            hintStyle ??
            Styles.textStyle16w4.copyWith(
              color:
                  ColorsManager.textColorInTextField, // Default hint text color
              fontSize: 14,
            ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: prefixIcon,
        ),
        suffixIcon: suffixIcon,
        suffixText: suffixText,
        suffix: suffix,
        fillColor: Colors.white,
        filled: true,
        constraints: const BoxConstraints(
          // maxWidth: 450,
        ),
        enabledBorder: customOutlinedBorder(),
        focusedBorder: customOutlinedBorder(color: ColorsManager.primary),
        errorBorder: customOutlinedBorder(color: ColorsManager.errorColor),
        focusedErrorBorder: customOutlinedBorder(
          color: ColorsManager.errorColor,
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
