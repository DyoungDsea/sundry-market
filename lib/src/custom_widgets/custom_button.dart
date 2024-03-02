import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.height = 50,
    this.onPressed,
    this.backgroundColor = const Color(0xFF198754),
    this.color = Colors.white,
    required this.title,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w500,
    this.borderColor = const Color(0xFF198754),
    this.borderWidth = 1.0,
  }) : super(key: key);
  final double? height;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? color;
  final Widget title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor,
          disabledForegroundColor: color,
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          side: BorderSide(
            color: borderColor!,
            width: borderWidth!,
          ),
        ),
        child: title,
      ),
    );
  }
}
