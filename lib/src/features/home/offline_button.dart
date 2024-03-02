import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_color.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';

class OfflineButton extends StatelessWidget {
  const OfflineButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomElevatedButton(
              onPressed: () => GoRouter.of(context).go('/offline'),
              title: const CustomText(
                title: "CLOCK-IN OFFLINE",
                color: orangeColor,
              ),
              backgroundColor: whiteColor,
              borderColor: orangeColor,
            ),
          ],
        ),
      ),
    );
  }
}
