// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final double elevation;
  final List<Widget>? action;
  final IconThemeData? iconThemeData;

  const CustomAppBar({
    Key? key,
    this.elevation = 0,
    this.backgroundColor,
    this.action,
    this.iconThemeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const CustomText(
        title: "HR-Live Clock",
        color: whiteColor,
      ),
      backgroundColor: backgroundColor, // Use your desired background color
      elevation: elevation, // Remove shadow
      iconTheme: iconThemeData, // Customize icon color
      actions: action,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
