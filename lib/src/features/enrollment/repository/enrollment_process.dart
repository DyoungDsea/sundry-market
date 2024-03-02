import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../custom_widgets/custom_exception.dart';
import '../../../utils/api.dart';
import '../../../utils/model/staff_model.dart';

class EnrollmentRepository {
  bool isAuthenticated = false;
  final http.Client client = http.Client();

  Future<Staff> getStaffInformation(String accessToken) async {
    final response = await http.get(
      Uri.parse("${API.staffcode}?staffcode=$accessToken"),
    );

    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return Staff.fromJson(jsonResponse['staff']);
    } else if (response.statusCode == 400) {
      // Handle specific error cases
      if (jsonResponse['ACCESS_CODE'] == 'DENIED') {
        throw ResultNotFoundError(jsonResponse['msg']);
      } else {
        throw Exception('Someting went wrong!');
      }
    } else {
      // Handle error cases
      throw Exception('Someting went wrong!');
    }
  }

  // Dispose the client when it's no longer needed
  void dispose() {
    client.close();
  }
}
