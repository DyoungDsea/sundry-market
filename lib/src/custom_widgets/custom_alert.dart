// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
  

class CustomAlert extends StatelessWidget {
  const CustomAlert({
    Key? key,
    required this.action,
    required this.content,
    this.title = 'Alert',
    this.backgroundColor = Colors.red,
    this.textColor = Colors.black87,
    required this.onPressed,
  }) : super(key: key);

  final List<Widget> action;
  final Widget content;
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      content: content,
      actions: action,
    );
  }
}
