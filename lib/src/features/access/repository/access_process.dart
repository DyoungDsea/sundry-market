import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../custom_widgets/custom_exception.dart';
import '../../../utils/api.dart';
import '../../../utils/share_preference.dart';
import 'model/acess_model.dart';

class AccessRepository {
  bool isAuthenticated = false;
  final http.Client client = http.Client();

  Future<void> companyAccessCode(String accessToken) async {
    try {
      final response = await client.post(
        Uri.parse(API.accessCode),
        body: {'companyAccess': accessToken},
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        CompanyAccess companyAccess = CompanyAccess.fromJson(jsonResponse);
        CompanyPreferences.saveCompanyAccess(companyAccess);
        isAuthenticated = true;
      } else if (response.statusCode == 400) {
        // Handle specific error cases
        if (jsonResponse['ACCESS_CODE'] == 'DENIED') {
          throw AccessDeniedError(jsonResponse['msg']);
        } else {
          throw LoginFailedError('Login failed');
        }
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

  // Dispose the client when it's no longer needed
  void dispose() {
    client.close();
  }
}
