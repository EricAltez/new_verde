import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {
      required this.email,
      required this.name,
      required this.points,
      required this.scanNumber,
      required this.organico,
      required this.carton,
      required this.plastico
      });

  final String email;
  final String name;
  final int points;
  final int scanNumber;
  final int organico;
  final int carton;
  final int plastico;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"],
        points: json["points"],
        scanNumber: json["scanNumber"],
        organico: json["organico"],
        carton: json["carton"],
        plastico: json["plastico"]
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "points": points,
        "scanNumber": scanNumber,
        "organico": organico,
        "carton": carton,
        "plastico": plastico
      };
}
