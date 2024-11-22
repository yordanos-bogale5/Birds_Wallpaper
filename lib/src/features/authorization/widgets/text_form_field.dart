import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

import '../../../utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Color backgroundColor;
  final String? SVG;
  final TextStyle? hintStyle;
  final String hintText;
  final TextStyle? textStyle;
  final int? maxLine;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  final TextInputType? textInputType;
  final List<String>? autofillHints;
  final Widget? suffixWidget;
  final double? borderRadius;
  const CustomTextFormField(
      {super.key,
      required this.backgroundColor,
      this.SVG,
      this.hintStyle,
      required this.hintText,
      required this.controller,
      this.textStyle,
      this.maxLine,
      this.obscureText,
      this.validator,
      this.textInputType,
      this.autofillHints,
      this.suffixWidget,
      this.onChanged, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: textStyle,
      autofillHints: autofillHints,
      maxLines: maxLine ?? 1,
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      decoration: InputDecoration(
          suffixIcon: suffixWidget,
          prefixIcon: SVG == null
              ? null
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    SVG!,
                    height: 20,
                    width: 20,
                  ),
                ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius??15),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius??15),
              borderSide: const BorderSide(color: errorColor, width: 1)),
          errorStyle: const TextStyle(color: errorColor),
          fillColor: backgroundColor,
          filled: true,
          hintText: hintText,
          hintStyle: hintStyle ??
              const TextStyle(
                  color: AppColors.hintColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
      validator: validator ??
          (String? val) {
            return null;
          },
      expands: false,
    );
  }
}
