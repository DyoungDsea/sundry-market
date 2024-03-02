// To parse this JSON data, do
//
//     final companyAccess = companyAccessFromJson(jsonString);

import 'dart:convert';

CompanyAccess companyAccessFromJson(String str) =>
    CompanyAccess.fromJson(json.decode(str));

String companyAccessToJson(CompanyAccess data) => json.encode(data.toJson());

class CompanyAccess {
  String? accessCode;
  String? token;
  String? msg;

  CompanyAccess({
    this.accessCode,
    this.token,
    this.msg,
  });

  factory CompanyAccess.fromJson(Map<String, dynamic> json) => CompanyAccess(
        accessCode: json["ACCESS_CODE"],
        token: json["token"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "ACCESS_CODE": accessCode,
        "token": token,
        "msg": msg,
      };
}
