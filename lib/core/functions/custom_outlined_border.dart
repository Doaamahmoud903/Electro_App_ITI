import 'package:electro/core/theming/color_manager.dart';
import 'package:flutter/material.dart';

OutlineInputBorder customOutlinedBorder({Color? color}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color ?? ColorsManager.textColorInTextField),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
  );
}
