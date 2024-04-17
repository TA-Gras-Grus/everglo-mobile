// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String? userId;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? image;
  final String? owned;
  final String? token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.image,
    this.owned,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
        image: json["image"],
        owned: json["owned"],
        token: json["token"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "image": image,
        "owned": owned,
        "token": token,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
