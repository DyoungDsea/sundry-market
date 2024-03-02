import 'package:flutter/material.dart';
import '../../constants/app_color.dart';
import '../../utils/share_preference.dart';
import '../home/home.dart';
import 'get_started_container.dart';
import '../logo/app_logo.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CompanyPreferences.readCompanyAccess(),
        builder: (_, snapshotData) {
          if (snapshotData.data != null) {
            return const HomePage();
          }
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [orangeColor, deepOrange],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 200, // Adjust top position as needed
                    left: (MediaQuery.of(context).size.width - 220) / 2,
                    child: const CustomLogo(),
                  ),
                  const ButtonContainer(),
                ],
              ),
            ),
          );
        });
  }
}
