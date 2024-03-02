import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 

import '../../constants/app_color.dart';
import '../../constants/app_sizes.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';

class ClockButton extends StatelessWidget {
  const ClockButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () => GoRouter.of(context).go('/enrollmentForm'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const CustomText(
                      title: "New Enrollment",
                      fontWeight: FontWeight.w500,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            gapH64,
            CustomElevatedButton(
              onPressed: () => GoRouter.of(context).go('/clockin'),
              title: const CustomText(
                title: "CLOCK-IN",
                color: whiteColor,
              ),
              backgroundColor: clockinColor,
              borderColor: clockinColor,
            ),
            gapH24,
            CustomElevatedButton(
              onPressed: () => GoRouter.of(context).go('/clockout'),
              title: const CustomText(
                title: "CLOCK-OUT",
              ),
              backgroundColor: redColor,
              borderColor: redColor,
            ),
          ],
        ),
      ),
    );
  }
}
