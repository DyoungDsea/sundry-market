import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_color.dart';
import '../../constants/app_sizes.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 29, vertical: 15),
              child: CustomText(
                title: 'Time & Attendance Management system',
                fontSize: 15,
                textOverflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
            ),
            gapH16,
            CustomElevatedButton(
              title: const CustomText(
                title: 'Get Started',
                color: orangeColor,
                fontWeight: FontWeight.w500,
              ),
              onPressed: () => GoRouter.of(context).go('/accessForm'),
              backgroundColor: whiteColor,
              borderColor: orangeColor,
            ),
            gapH48,
            const CustomText(
              title: "Powered by HR-Live",
              fontSize: 10,
              fontWeight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}
