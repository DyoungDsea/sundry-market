import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'clock_buttons.dart';
import 'custom_network_alert.dart';
import 'offline_bloc/offline_bloc.dart';
import 'offline_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    checkConnectivityOnStartup();
  }

  Future<void> checkConnectivityOnStartup() async {
    var connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      showNetworkAlertDialog();
    }
  }

  Future<void> showNetworkAlertDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: BlocProvider<OfflineModeBloc>(
            create: (context) => OfflineModeBloc(),
            child: BlocBuilder<OfflineModeBloc, OfflineModeState>(
                builder: (context, state) {
              // print(state);
              final offlineModeBloc = context.read<OfflineModeBloc>();
              return AlertDialog(
                backgroundColor: whiteColor,
                title: const CustomText(
                  title: 'No Internet Connection',
                  fontWeight: FontWeight.w600,
                ),
                content: const CustomText(
                  title: offlineAlert,
                  textOverflow: TextOverflow.visible,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // GoRouter.of(context).pop();
                      offlineModeBloc.add(OfflineModeEvent.enableOfflineMode);
                    },
                    child: const CustomText(title: 'Continue Offline'),
                  ),
                  gapH16,
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const CustomText(title: 'Connect to Network'),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }

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
                decoration: const BoxDecoration(
                  color: whiteColor, // Change the color to your preference
                ),
                child: Image.asset(
                  'assets/logo.png', // Replace with your image asset path
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
          child: BlocProvider<OfflineModeBloc>(
            create: (context) => OfflineModeBloc(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomLogo(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 29, vertical: 15),
                  child: CustomText(
                    title: appTitle,
                    fontSize: 12,
                    textOverflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                ),
                gapH24,
                BlocBuilder<OfflineModeBloc, OfflineModeState>(
                    builder: (context, state) {
                  return state.isOfflineModeEnabled
                      ? const OfflineButton()
                      : const ClockButton();
                }),
                gapH24,
                BlocBuilder<OfflineModeBloc, OfflineModeState>(
                    builder: (context, state) {
                  final offlineModeBloc = context.read<OfflineModeBloc>();
                  return state.isOfflineModeEnabled
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
                                    offlineModeBloc.add(
                                        OfflineModeEvent.disableOfflineMode);
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
                                    offlineModeBloc.add(
                                        OfflineModeEvent.enableOfflineMode);
                                  },
                                );
                              },
                            );
                          },
                          child: const CustomText(title: "OFFLINE CLOCK-IN"),
                        );
                }),
                gapH48,
                const CustomText(
                  title: powerBy,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                )
              ],
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
