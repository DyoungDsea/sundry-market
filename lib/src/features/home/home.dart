import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_color.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text.dart';
import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_text.dart';
import '../../utils/share_preference.dart';
import '../logo/app_logo.dart';
import 'bloc/new_bloc.dart';
import 'clock_buttons.dart';
import 'custom_network_alert.dart';
import 'offline_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(),
      drawer: Container(
        width: 200,
        color: whiteColor,
        child: Drawer(
          backgroundColor: whiteColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: whiteColor),
                child: Image.asset(
                  appLogo,
                  fit: BoxFit.contain,
                ),
              ),
              buildDrawerItem(Icons.home, 'Home', () {
                // Navigate to home page or perform any action
                Navigator.pop(context);
              }),
              buildDrawerItem(Icons.info, 'About', () {
                // Navigate to about page or perform any action
              }),
              buildDrawerItem(Icons.note_add, 'Enrollment', () {
                GoRouter.of(context).pop();
                GoRouter.of(context).go('/enrollmentForm');
              }),
              buildDrawerItem(Icons.logout, 'Logout', () {
                // Perform logout action
                GoRouter.of(context).pop();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: whiteColor,
                        title: const CustomText(
                          title: 'Logout Confirmation',
                          fontWeight: FontWeight.w600,
                        ),
                        content: const CustomText(
                            title: 'Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).pop();
                              CompanyPreferences.removeCompanyAccessInfo();
                              GoRouter.of(context).pushReplacement('/');
                            },
                            child: const CustomText(title: 'Yes, Logout'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const CustomText(title: 'No'),
                          ),
                        ],
                      );
                    });
              }),
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocProvider<NewBloc>(
            create: (context) => NewBloc()..add(NetworkMode()),
            child: BlocConsumer<NewBloc, NewState>(
              listener: (context, state) {
                final isEnableBtn = context.read<NewBloc>();
                if (state is IsOfflineState) {
                  //do offline mode
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return CustomNetworkAlert(
                        title: 'No Internet Connection',
                        subTitle: offlineAlert,
                        yes: 'Offline',
                        no: 'Online',
                        onPressed: () {
                          GoRouter.of(context).pop();
                          isEnableBtn.add(const AppMode(true));
                        },
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomLogo(),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 29, vertical: 15),
                      child: CustomText(
                        title: appTitle,
                        fontSize: 12,
                        textOverflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    gapH24,
                    BlocBuilder<NewBloc, NewState>(builder: (context, state) {
                      return state is OfflineState
                          ? const OfflineButton()
                          : const ClockButton();
                    }),
                    gapH24,
                    BlocBuilder<NewBloc, NewState>(builder: (context, state) {
                      final isEnableBtn = context.read<NewBloc>();
                      return state is OfflineState
                          ? TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomNetworkAlert(
                                      title: 'Enable Online Mode?',
                                      subTitle: onlineText,
                                      onPressed: () {
                                        GoRouter.of(context).pop();
                                        isEnableBtn.add(const AppMode(false));
                                      },
                                    );
                                  },
                                );
                              },
                              child: const CustomText(
                                title: "GO ONLINE ",
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomNetworkAlert(
                                      title: 'Enable Offline Mode?',
                                      subTitle: offlineText,
                                      onPressed: () {
                                        GoRouter.of(context).pop();
                                        isEnableBtn.add(const AppMode(true));
                                      },
                                    );
                                  },
                                );
                              },
                              child:
                                  const CustomText(title: "OFFLINE CLOCK-IN"),
                            );
                    }),
                    gapH48,
                    const CustomText(
                      title: powerBy,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
