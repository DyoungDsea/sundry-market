import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../custom_widgets/custom_exception.dart';
import '../../features/access/repository/model/acess_model.dart';
import '../api.dart';
import '../functions.dart';
import '../model/staff_model.dart';
import '../share_preference.dart';

class StaffRepository {
  bool isAuthenticated = false;
  final http.Client client = http.Client();

//!get staff information
  Future<Staff> getStaffInformation(String accessToken, String status) async {
    CompanyAccess? companyAccess = await CompanyPreferences.getCompanyAccess();
    final key = companyAccess!.token;

    try {
      final response = await http.get(
        Uri.parse(
            "${API.staffcode}?staffcode=$accessToken&status=$status&key=$key"),
      );

      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return Staff.fromJson(jsonResponse['staff']);
      } else if (response.statusCode == 400) {
        throw AccessDeniedError(jsonResponse['msg']);
      } else {
        throw ServerError('Server error occurred');
      }
      // ignore: unused_catch_clause
    } on SocketException catch (e) {
      // print(e.message);
      throw NetworkError(
          'Network error: Please check your network connection and make sure is active and try again.');
    } catch (e) {
      // Rethrow the original exception
      rethrow;
    }
  }

  //!function to process enrollments
  Future<void> processEnrollment(String staffCode) async {
    final imagePath = await AppFunctions.captureAndCompressImage();
    CompanyAccess? companyAccess = await CompanyPreferences.getCompanyAccess();
    final key = companyAccess!.token;

    if (imagePath != null) {
      final uri = Uri.parse(API.enrollment);
      try {
        // Create a multipart request
        final request = http.MultipartRequest('POST', uri);
        // Attach image file
        request.files.add(await http.MultipartFile.fromPath('img', imagePath));
        request.fields['staffcode'] = staffCode;
        request.fields['key'] = key!;

        // Send the request
        final response = await request.send();
        // Get the response as a string
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        if (response.statusCode == 200) {
          // print("this section is working");
        } else {
          if (jsonResponse['ACCESS_CODE'] == 'DENIED') {
            throw ResultNotFoundError(
                'Fail, We\'re unable to enroll your account, please try again');
          } else {
            throw ResultNotFoundError('Someting went wrong!');
          }
        }
      } catch (e) {
        // print('Error submitting to API: $e');
        throw ResultNotFoundError(e.toString());
      }
    } else {
      throw ResultNotFoundError("Take clear capture of yourself and try again");
    }
  }

//! process staff clock-in and clock-out

  Future<void> processClock(String staffcode, String status) async {
    final imagePath = await AppFunctions.captureAndCompressImage();
    if (imagePath != null) {
      final uri = Uri.parse(API.clock);
      CompanyAccess? companyAccess =
          await CompanyPreferences.getCompanyAccess();
      final key = companyAccess!.token;
      try {
        // Create a multipart request
        final request = http.MultipartRequest('POST', uri);
        // Attach image file
        request.files.add(await http.MultipartFile.fromPath('img', imagePath));
        request.fields['staffcode'] = staffcode;
        request.fields['status'] = status;

        final position = await AppFunctions.getLocation();
        request.fields['latitude'] = position!.latitude.toString();
        request.fields['longitude'] = position.longitude.toString();
        final address = await AppFunctions.getAddressFromLocation(
            position.latitude, position.longitude);
        request.fields['address'] = address;

        request.fields['key'] = key!;
        // Send the request
        final response = await request.send();
        // Get the response as a string
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        if (response.statusCode == 200) {
          // print("this section is working");
        } else {
          if (jsonResponse['ACCESS_CODE'] == 'DENIED') {
            throw ResultNotFoundError(
                'Fail, We\'re unable to , please try again');
          } else {
            throw ResultNotFoundError('Someting went wrong!');
          }
        }
      } catch (e) {
        // print('Error submitting to API: $e');
        throw ResultNotFoundError(e.toString());
      }
    } else {
      throw ResultNotFoundError("Take clear capture of yourself and try again");
    }
  }

  // Dispose the client when it's no longer needed
  void dispose() {
    client.close();
  }
}
