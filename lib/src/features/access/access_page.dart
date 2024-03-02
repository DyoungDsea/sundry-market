import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_color.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text.dart';
import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_text.dart';
import '../logo/app_logo.dart';
import 'bloc/access_bloc.dart';
import 'form_container.dart';

class AccessForm extends StatefulWidget {
  const AccessForm({super.key});

  @override
  State<AccessForm> createState() => _AccessFormState();
}

class _AccessFormState extends State<AccessForm> {
  final TextEditingController companyCode = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    var status = await Permission.location.status;
    if (status != PermissionStatus.granted) {
      _showLocationPermissionDialog();
    }
  }

  Future<void> _showLocationPermissionDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: const CustomText(
            title: "Permission Required",
            fontWeight: FontWeight.w600,
          ),
          content: const CustomText(
            title: "Please enable location services to use this app.",
            textOverflow: TextOverflow.visible,
          ),
          actions: <Widget>[
            TextButton(
              child: const CustomText(title: "Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const CustomText(title: "Open Settings"),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
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
      appBar: const CustomAppBar(),
      body: Container(
        decoration: const BoxDecoration(color: whiteColor),
        child: BlocProvider<AccessBloc>(
          create: (context) => AccessBloc(),
          child: Center(
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
                  BlocConsumer<AccessBloc, AccessState>(
                    listener: (context, state) {
                      if (state is AccessSuccessState) {
                        //navigate to EnrollmentForm
                        GoRouter.of(context).pushReplacement('/enrollmentForm');
                      } else if (state is AccessFailState) {
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
                      }
                    },
                    builder: (context, state) {
                      // final accessBloc = BlocProvider.of<AccessBloc>(context);
                      return Form(
                        key: formKey,
                        child: FormContainer(
                          formKey: formKey,
                          companyController: companyCode,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
