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
import 'bloc/enrollment_bloc.dart';
import 'capture.dart';

class EnrollmentForm extends StatefulWidget {
  const EnrollmentForm({super.key});

  @override
  State<EnrollmentForm> createState() => _EnrollmentFormState();
}

class _EnrollmentFormState extends State<EnrollmentForm> {
  final TextEditingController staffCode = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    staffCode.dispose();
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
              gapH32,
              const CustomText(
                title: 'Enrollment',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 60,
                child: Divider(
                  color: orangeColor,
                  thickness: 2,
                ),
              ),
              gapH24,
              BlocProvider<EnrollmentBloc>(
                create: (context) => EnrollmentBloc(),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              validator: (value) =>
                                  value == "" ? "Staff code is required" : null,
                              controller: staffCode,
                              labelText: "STAFF CODE",
                              cursorColor: orangeColor,
                              borderColor: orangeColor,
                              enableBorderColor: orangeColor,
                              focusedBorderColor: orangeColor,
                              disabledBorderColor: orangeColor,
                              inputFormatters: [UpperCaseTextFormatter()],
                            ),
                            gapH16,
                            BlocConsumer<EnrollmentBloc, EnrollmentState>(
                                listener: (context, state) {
                              if (state is EnrollmentFailState) {
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
                              } else if (state is EnrollmentSuccessState) {
                                final staff = state.staff;
                                if (staff.luxEnrolled == 'yes') {
                                  //User is already enrolled
                                  // showEnrollmentBottomSheet(
                                  //     context, staff.fullname!);
                                  AppFunctions.showCustomBottomSheet(
                                    context,
                                    [
                                      gapH16,
                                      CustomText(
                                        title: staff.fullname!,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      gapH12,
                                      const CustomText(
                                        title: 'You\'ve already enrolled!',
                                        fontWeight: FontWeight.w400,
                                        color: redColor,
                                      ),
                                      gapH12,
                                      const CustomText(
                                        title:
                                            'If you want to re-enroll, click on continue.',
                                        textAlign: TextAlign.center,
                                        textOverflow: TextOverflow.visible,
                                      ),
                                      gapH20,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CapturePhoto(
                                                    fullname: staff.fullname!,
                                                    staffCode: staff.staffcode!,
                                                  ),
                                                ),
                                              ); // Close the bottom sheet
                                            },
                                            title: const CustomText(
                                              title: 'Continue',
                                              color: orangeColor,
                                            ),
                                            borderColor: orangeColor,
                                            backgroundColor: whiteColor,
                                          ),
                                          gapW24,
                                          CustomElevatedButton(
                                            onPressed: () =>
                                                GoRouter.of(context)
                                                    .go('/home'),
                                            title: const CustomText(
                                              title: 'Cancel',
                                              color: whiteColor,
                                            ),
                                            borderColor: orangeColor,
                                            backgroundColor: orangeColor,
                                          ),
                                        ],
                                      ),
                                      gapH48
                                    ],
                                  );
                                } else {
                                  //take user to entrollment page
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CapturePhoto(
                                          fullname: staff.fullname!,
                                          staffCode: staff.staffcode!),
                                    ),
                                  );
                                }
                              }
                            }, builder: (context, state) {
                              final enrollmentBloc =
                                  context.read<EnrollmentBloc>();

                              return state is EnrollmentLoadingState
                                  ? CustomElevatedButton(
                                      onPressed: null,
                                      title: processingRow(),
                                      backgroundColor: orangeColor,
                                      borderColor: orangeColor,
                                    )
                                  : CustomElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          AppFunctions.dismiss(context);
                                          enrollmentBloc.add(
                                            StaffCodeEnrollmentEvent(
                                              staffCode: staffCode.text,
                                            ),
                                          );
                                        }
                                      },
                                      title: const CustomText(title: "Proceed"),
                                      backgroundColor: orangeColor,
                                      borderColor: orangeColor,
                                    );
                            }),
                          ],
                        ),
                      ),
                      gapH32,
                      TextButton(
                        onPressed: () => GoRouter.of(context).go('/home'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(blackColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const CustomText(
                          title: "Skip",
                          fontWeight: FontWeight.w500,
                          color: whiteColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
