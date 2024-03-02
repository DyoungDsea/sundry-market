// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_color.dart';
import '../../custom_widgets/custom_text.dart';

class CustomNetworkAlert extends StatelessWidget {
  const CustomNetworkAlert({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.subTitle,
     this.yes = "Yes",
     this.no = "No",
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final String subTitle;
  final String yes;
  final String no;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title: CustomText(
        title: title,
        fontWeight: FontWeight.w600,
      ),
      content: CustomText(
        title: subTitle,
        textOverflow: TextOverflow.visible,
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child:  Text(yes),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child:  Text(no),
        ),
      ],
    );
  }
}
