import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.borderColor = Colors.black45,
    this.cursorColor = Colors.black45,
    this.enableBorderColor = Colors.black45,
    this.focusedBorderColor = Colors.black45,
    this.disabledBorderColor = Colors.black45,
    this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 6,
    ),
    this.hintText,
    this.style,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? enableBorderColor;
  final Color? focusedBorderColor;
  final Color? disabledBorderColor;
  final Color? cursorColor;
  final String? labelText;
  final bool? obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  final TextStyle? style;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      cursorColor: cursorColor,
      validator: validator,
      inputFormatters: inputFormatters,
      obscureText: obscureText!,
      maxLines: maxLines,
      textAlign: textAlign!,
      style: style,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: borderColor!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: enableBorderColor!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: focusedBorderColor!,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: disabledBorderColor!,
          ),
        ),
        contentPadding: contentPadding,
      ),
    );
  }
}
