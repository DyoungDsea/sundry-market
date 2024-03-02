import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class CustomSelectedField extends StatelessWidget {
  const CustomSelectedField({
    Key? key,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.items,
    this.prefixIcon,
    this.borderColor = Colors.black45,
    this.enableBorderColor = Colors.black45,
    this.focusedBorderColor = Colors.black45,
    this.disabledBorderColor = Colors.black45,
    this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
    this.initialValue = '',
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 6,
    ),
    this.hintText,
    this.style,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? enableBorderColor;
  final Color? focusedBorderColor;
  final Color? disabledBorderColor;
  final String? labelText;
  final bool? obscureText;
  final Widget? suffixIcon;
  final int maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  final String? initialValue;
  final TextStyle? style;
  final TextAlign? textAlign;
  final List<Map<String, dynamic>>? items;

  @override
  Widget build(BuildContext context) {
    return SelectFormField(
      controller: controller,
      type: SelectFormFieldType.dropdown,
      keyboardType: textInputType,
      validator: validator,
      obscureText: obscureText!,
      initialValue: initialValue,
      items: items,
      maxLines: maxLines,
      textAlign: textAlign!,
      style: style,
      onChanged: onChanged,
      onSaved: onSaved,
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
