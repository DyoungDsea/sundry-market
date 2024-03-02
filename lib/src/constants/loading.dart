import 'package:flutter/material.dart';
import '../custom_widgets/custom_text.dart';
import 'app_color.dart';

Widget processingRow({
  String title = "Processing",
  Color? color = whiteColor,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CustomText(
        title: title,
        color: color,
      ),
      const SizedBox(width: 24.0),
      SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 2.0,
        ),
      ),
    ],
  );
}
