import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../constants/app_text.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 220,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(-2, 2),
          ),
        ],
      ),
      child: Image.asset(
        appLogo,
        fit: BoxFit.cover,
      ),
    );
  }
}
