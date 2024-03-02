import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_color.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_text.dart';
import '../../../constants/loading.dart';
import '../../../custom_widgets/custom_appbar.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_text.dart';
import '../../../custom_widgets/custom_textfield.dart';
import '../../../custom_widgets/format_textinput.dart';
import '../../../utils/functions.dart';
import '../../logo/app_logo.dart';
import '../bloc/new_bloc.dart';

class ClockOffline extends StatefulWidget {
  const ClockOffline({super.key});

  @override
  State<ClockOffline> createState() => _ClockOfflineState();
}

class _ClockOfflineState extends State<ClockOffline> {
  final TextEditingController staffController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  dispose() {
    staffController.dispose();
    super.dispose();
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
                child: BlocProvider<NewBloc>(
                  create: (context) => NewBloc(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocConsumer<NewBloc, NewState>(
                            listener: (context, state) {
                          if (state is OfflineSuccess) {
                            GoRouter.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: greenColor,
                                showCloseIcon: true,
                                content: CustomText(
                                  title:
                                      "You've clocked-in in oflline mode sucessfully",
                                  color: whiteColor,
                                  textOverflow: TextOverflow.visible,
                                ),
                                duration: Duration(seconds: 30),
                              ),
                            );
                          } else if (state is OfflineFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: redColor,
                                content: CustomText(
                                  title:
                                      "Something went wrong, try again later",
                                  color: whiteColor,
                                  textOverflow: TextOverflow.visible,
                                ),
                                duration: Duration(seconds: 15),
                              ),
                            );
                          } else if (state is OnlineState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: redColor,
                                content: CustomText(
                                  title:
                                      "Sorry, this can only be done if you're not connected to any internet, turn off your network and try again",
                                  color: whiteColor,
                                  textOverflow: TextOverflow.visible,
                                ),
                                duration: Duration(seconds: 30),
                              ),
                            );
                          }
                        }, builder: (context, state) {
                          final btn = context.read<NewBloc>();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextField(
                                validator: (value) => value == ""
                                    ? "Staff code is required"
                                    : null,
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
                              state is OfflineLoading
                                  ? CustomElevatedButton(
                                      title: processingRow(
                                        title: 'Please wait',
                                        color: orangeColor,
                                      ),
                                      onPressed: null,
                                      backgroundColor: whiteColor,
                                      borderColor: orangeColor,
                                    )
                                  : CustomElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          AppFunctions.dismiss(context);
                                          btn.add(OfflineEvent(
                                              staffController.text));
                                        }
                                      },
                                      title: const CustomText(
                                        title: "CLOCK-IN (OFFLINE)",
                                        color: whiteColor,
                                      ),
                                      backgroundColor: orangeColor,
                                      borderColor: orangeColor,
                                    )
                            ],
                          );
                        }),
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
