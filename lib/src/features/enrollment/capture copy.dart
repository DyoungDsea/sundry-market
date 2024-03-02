// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import 'bloc/enrollment_bloc.dart';

class CapturePhoto extends StatelessWidget {
  const CapturePhoto({
    Key? key,
    required this.fullname,
    required this.staffCode,
  }) : super(key: key);
  final String fullname;
  final String staffCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: whiteColor,
      body: BlocProvider<EnrollmentBloc>(
        create: (context) => EnrollmentBloc(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: fullname,
                fontWeight: FontWeight.w600,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  title:
                      "Stay in a very clear position and capture your face clearly",
                  textOverflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
              ),
              gapH24,
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: orangeColor),
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: orangeColor,
                  ),
                ),
              ),
              gapH24,
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
                  } else if (state is EnrollmentSuccessfulState) {
                    //take staff to home page for clock.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: greenColor,
                        content: CustomText(
                          title: "Your enrollment was successfully!",
                          color: whiteColor,
                          textOverflow: TextOverflow.visible,
                        ),
                      ),
                    );
                    GoRouter.of(context).go('/home');
                  }
                },
                builder: (context, state) {
                  final btn = context.read<EnrollmentBloc>();
                  return SizedBox(
                    width: 200,
                    child: state is EnrollmentLoadingState
                        ? CustomElevatedButton(
                            title: processingRow(title: "Please wait"),
                            onPressed: null,
                            backgroundColor: orangeColor,
                            borderColor: orangeColor,
                          )
                        : CustomElevatedButton(
                            onPressed: () => btn.add(
                                CaptureEnrollmentEvent(staffCode: staffCode)),
                            title: const CustomText(
                              title: "CAPTURE",
                              color: orangeColor,
                            ),
                            backgroundColor: whiteColor,
                            borderColor: orangeColor,
                          ),
                  );
                },
              ),
              gapH64,
              const CustomText(title: powerBy),
            ],
          ),
        ),
      ),
    );
  }
}
