import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../features/access/repository/model/acess_model.dart';

class CompanyPreferences {
  //save CompanyAccess info locally with sharedpreferences
  static Future<void> saveCompanyAccess(CompanyAccess companyAccess) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String accessJsonData = jsonEncode(companyAccess.toJson());
    await preferences.setString("currentToken", accessJsonData);
  }

  //Read ComapnyAccess
  static Future<CompanyAccess?> readCompanyAccess() async {
    CompanyAccess? currentCompanyAccess;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessInfo = preferences.getString("currentToken");
    if (accessInfo != null) {
      Map<String, dynamic> accessDataMap = jsonDecode(accessInfo);
      currentCompanyAccess = CompanyAccess.fromJson(accessDataMap);
    }

    return currentCompanyAccess;
  }

  static Future<CompanyAccess?> getCompanyAccess() async {
    CompanyAccess? currentCompanyAccess;
    final prefs = await SharedPreferences.getInstance();
    String? accessInfo = prefs.getString("currentToken");
    if (accessInfo != null) {
      Map<String, dynamic> accessDataMap = jsonDecode(accessInfo);
      currentCompanyAccess = CompanyAccess.fromJson(accessDataMap);
    }
    return currentCompanyAccess;
  }

  static Future<void> removeCompanyAccessInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('currentToken');
  }
}
