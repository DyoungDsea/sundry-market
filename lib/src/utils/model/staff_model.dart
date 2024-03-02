// To parse this JSON data, do
//
//     final staff = staffFromJson(jsonString);

import 'dart:convert';

Staff staffFromJson(String str) => Staff.fromJson(json.decode(str));

String staffToJson(Staff data) => json.encode(data.toJson());

class Staff {
    String? staffcode;
    String? fullname;
    String? email;
    String? position;
    String? luxEnrolled;

    Staff({
        this.staffcode,
        this.fullname,
        this.email,
        this.position,
        this.luxEnrolled,
    });

    factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        staffcode: json["staffcode"],
        fullname: json["fullname"],
        email: json["email"],
        position: json["position"],
        luxEnrolled: json["lux_enrolled"],
    );

    Map<String, dynamic> toJson() => {
        "staffcode": staffcode,
        "fullname": fullname,
        "email": email,
        "position": position,
        "luxEnrolled": luxEnrolled,
    };
}
