// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 

import '../../constants/app_color.dart';
import '../../constants/app_sizes.dart';
import '../../constants/loading.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/format_textinput.dart';
import '../../utils/functions.dart';
import 'bloc/access_bloc.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({
    Key? key,
    required this.companyController,
    required this.formKey,
  }) : super(key: key);
  final TextEditingController companyController;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final accessBloc = BlocProvider.of<AccessBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                validator: (value) =>
                    value == "" ? "Company access code is required" : null,
                controller: companyController,
                labelText: "COMPANY ACCESS CODE",
                cursorColor: orangeColor,
                borderColor: orangeColor,
                enableBorderColor: orangeColor,
                focusedBorderColor: orangeColor,
                disabledBorderColor: orangeColor,
                inputFormatters: [UpperCaseTextFormatter()],
              ),
              gapH16,
              accessBloc.state is AccessIsLoadingState
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
                          accessBloc.add(
                            CompanyAccess(companyCode: companyController.text),
                          );
                        }
                      },
                      title: const CustomText(
                        title: "Proceed",
                      ),
                      backgroundColor: orangeColor,
                      borderColor: orangeColor,
                    ),
            ],
          ),
        ),
        gapH48,
        const CustomText(
          title: "Powered by HR-Live",
          fontSize: 10,
          fontWeight: FontWeight.w400,
        )
      ],
    );
  }
}
