import 'dart:convert';

UserM userFromJson(String str) => UserM.fromJson(json.decode(str));

String userToJson(UserM data) => json.encode(data.toJson());

class UserM {
  final String email;
  final String name;
  final int points;
  final int organico;
  final int carton;
  final int plastico;

  UserM(
      {required this.email,
      required this.name,
      required this.points,
      required this.organico,
      required this.carton,
      required this.plastico});

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "points": points,
        "organico": organico,
        "carton": carton,
        "plastico": plastico
      };

  static UserM fromJson(Map<String, dynamic> json) => UserM(
      email: json['email'],
      name: json['name'],
      points: json['points'],
      organico: json['organico'],
      carton: json['carton'],
      plastico: json['plastico']);
}
