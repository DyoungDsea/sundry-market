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
import '../enrollment/enrollment.dart';
import '../logo/app_logo.dart';
import 'bloc/capture_bloc.dart';
import 'bloc/clockin_bloc.dart';

class ClockOut extends StatefulWidget {
  const ClockOut({super.key});

  @override
  State<ClockOut> createState() => _ClockOutState();
}

class _ClockOutState extends State<ClockOut> {
  final TextEditingController staffController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                                        title: "Please enroll here",
                                        color: whiteColor,
                                        textOverflow: TextOverflow.visible,
                                      ),
                                    ),
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EnrollmentForm(),
                                    ),
                                  );
                                } else {
                                  //allow user to capture
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
                                        title: 'Ready to clock-out?',
                                        fontWeight: FontWeight.w500,
                                        color: redColor,
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
                                                      "You've clocked out sucessfully!",
                                                  color: whiteColor,
                                                  textOverflow:
                                                      TextOverflow.visible,
                                                ),
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
                                                        status: "Clockout",
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
                                              status: "Clockout",
                                            ),
                                          );
                                        }
                                      },
                                      title: const CustomText(
                                        title: "CLOCK-OUT",
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
