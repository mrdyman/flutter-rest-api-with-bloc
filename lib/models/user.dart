// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  int id;
  String name;
  String email;
  Gender gender;
  Status status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: genderValues.map[json["gender"]]!,
        status: statusValues.map[json["status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "gender": genderValues.reverse[gender],
        "status": statusValues.reverse[status],
      };
}

enum Gender { male, female }

final genderValues = EnumValues({"female": Gender.female, "male": Gender.male});

enum Status { inactive, active }

final statusValues =
    EnumValues({"active": Status.active, "inactive": Status.inactive});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
