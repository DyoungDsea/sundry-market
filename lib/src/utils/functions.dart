import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../constants/app_color.dart';

class AppFunctions {
  static void showCustomBottomSheet(
    BuildContext context,
    List<Widget> widgets,
  ) {
    showModalBottomSheet(
      backgroundColor: whiteColor,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widgets,
            ),
          ),
        );
      },
    );
  }

  static void dismiss(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Future<String?> captureAndCompressImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile != null) {
      return compressImage(pickedFile.path);
    } else {
      return null;
    }
  }

  static Future<String> compressImage(String imagePath) async {
    final dir = Directory.systemTemp;
    final targetPath = '${dir.absolute.path}/temp.jpg';

    var compressedFile = await FlutterImageCompress.compressAndGetFile(
      imagePath,
      targetPath,
      quality: 85,
      minWidth: 400,
      minHeight: 400,
    );

    return compressedFile!.path;
  }

  static Future<Position?> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    return position;
  }

  static Future<String> getAddressFromLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks.first;
      // return place.toString();
      return place.street ?? '';
      // return place.thoroughfare ?? '';
    } catch (e) {
      return '';
    }
  }

  static String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  static String getCurrentTime() {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    return formatter.format(now);
  }
}
