import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_color.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text.dart';
import '../../constants/loading.dart';
import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/format_textinput.dart';
import '../../utils/functions.dart';
import '../logo/app_logo.dart';
import 'bloc/capture_bloc.dart';
import 'bloc/clockin_bloc.dart';

class ClockIn extends StatefulWidget {
  const ClockIn({super.key});

  @override
  State<ClockIn> createState() => _ClockInState();
}

class _ClockInState extends State<ClockIn> {
  final TextEditingController staffController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  dispose() {
    staffController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkNetworkStatus();
    });
  }

  Future<void> checkNetworkStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      // Device is offline, show alert
      showOfflineModeDialog();
    }
  }

  Future<void> showOfflineModeDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomText(
            title: 'No Internet Connection',
            fontWeight: FontWeight.w700,
          ),
          content: const CustomText(
            title:
                'Put on your internet connection and press I\'m ready to continue',
            textOverflow: TextOverflow.visible,
          ),
          actions: <Widget>[
            TextButton(
              child: const CustomText(title: 'I\'m ready'),
              onPressed: () {
                GoRouter.of(context).pop();
                // setState(() {});
                // showOfflineModeDialog();
              },
            ),
            TextButton(
              child: const CustomText(title: 'Continue Offline'),
              onPressed: () {
                GoRouter.of(context).pop();
                GoRouter.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
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
              gapH64,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: BlocProvider<ClockinBloc>(
                  create: (context) => ClockinBloc(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              validator: (value) =>
                                  value == "" ? "Staff code is required" : null,
                              controller: staffController,
                              labelText: "STAFF CODE",
                              cursorColor: orangeColor,
                              borderColor: orangeColor,
                              enableBorderColor: orangeColor,
                              focusedBorderColor: orangeColor,
                              disabledBorderColor: orangeColor,
                              inputFormatters: [UpperCaseTextFormatter()],
                            ),
                            gapH16,
                            BlocConsumer<ClockinBloc, ClockinState>(
                                listener: (context, state) {
                              if (state is ClockinFailState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: redColor,
                                    content: CustomText(
                                      title: state.error,
                                      color: whiteColor,
                                      textOverflow: TextOverflow.visible,
                                    ),
                                  ),
                                );
                              } else if (state is ClockinSuccessState) {
                                final staff = state.staff;
                                if (staff.luxEnrolled == 'no') {
                                  //take user to enrollment screen
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: redColor,
                                      content: CustomText(
                                        title: "You need to enroll first.",
                                        color: whiteColor,
                                        textOverflow: TextOverflow.visible,
                                      ),
                                    ),
                                  );
                                  GoRouter.of(context).go('/enrollmentForm');
                                } else {
                                  //allow user to capture
                                  // print(state);
                                  AppFunctions.showCustomBottomSheet(
                                    context,
                                    [
                                      gapH16,
                                      CustomText(
                                        title: "${staff.fullname}",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      gapH12,
                                      CustomText(
                                        title: "${staff.position}",
                                        fontWeight: FontWeight.w400,
                                      ),
                                      gapH12,
                                      const CustomText(
                                        title: 'Ready to clock-in?',
                                        fontWeight: FontWeight.w500,
                                        color: greenColor,
                                      ),
                                      gapH20,
                                      BlocProvider<CaptureBloc>(
                                        create: (context) => CaptureBloc(),
                                        child: BlocConsumer<CaptureBloc,
                                                CaptureState>(
                                            listener: (context, state) {
                                          //? go to the home page on success
                                          if (state is CaptureSuccessState) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: greenColor,
                                                showCloseIcon: true,
                                                content: CustomText(
                                                  title:
                                                      "You've clocked in sucessfully",
                                                  color: whiteColor,
                                                  textOverflow:
                                                      TextOverflow.visible,
                                                ),
                                                duration: Duration(seconds: 30),
                                              ),
                                            );
                                            GoRouter.of(context).go('/home');
                                          }
                                        }, builder: (context, state) {
                                          return state is CaptureLoadingState
                                              ? SizedBox(
                                                  width: 230,
                                                  child: CustomElevatedButton(
                                                    title: processingRow(
                                                      title: 'Please wait',
                                                      color: orangeColor,
                                                    ),
                                                    onPressed: null,
                                                    backgroundColor: whiteColor,
                                                    borderColor: orangeColor,
                                                  ),
                                                )
                                              : CustomElevatedButton(
                                                  onPressed: () {
                                                    final clockBtn = context
                                                        .read<CaptureBloc>();
                                                    clockBtn.add(
                                                      StaffCapture(
                                                        staffCode:
                                                            staff.staffcode!,
                                                        status: "Clockin",
                                                      ),
                                                    );
                                                  },
                                                  title: const CustomText(
                                                    title: 'Yes, I\'m ready',
                                                    color: orangeColor,
                                                  ),
                                                  borderColor: orangeColor,
                                                  backgroundColor: whiteColor,
                                                );
                                        }),
                                      ),
                                      gapH48
                                    ],
                                  );
                                }
                              }
                            }, builder: (context, state) {
                              final clockBtn = context.read<ClockinBloc>();
                              return state is ClockinIsLoadingState
                                  ? CustomElevatedButton(
                                      title: processingRow(),
                                      onPressed: null,
                                      backgroundColor: orangeColor,
                                      borderColor: orangeColor,
                                    )
                                  : CustomElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          AppFunctions.dismiss(context);
                                          clockBtn.add(
                                            StaffClock(
                                              staffCode: staffController.text,
                                              status: "Clockin",
                                            ),
                                          );
                                        }
                                      },
                                      title: const CustomText(
                                        title: "CLOCK-IN",
                                        color: whiteColor,
                                      ),
                                      backgroundColor: orangeColor,
                                      borderColor: orangeColor,
                                    );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              gapH64,
              const CustomText(
                title: powerBy,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ),
      ),
    );
  }
}
