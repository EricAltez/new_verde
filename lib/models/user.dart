import 'dart:convert';

UserM userFromJson(String str) => UserM.fromJson(json.decode(str));

String userToJson(UserM data) => json.encode(data.toJson());

class UserM {
  String id;
  final String name;
  final int points;
  final int organico;
  final int carton;
  final int plastico;

  UserM({
    this.id = '',
    required this.name,
    required this.points,
    required this.organico,
    required this.carton,
    required this.plastico
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "points": points,
    "organico": organico,
    "carton": carton,
    "plastico": plastico
  };

  static UserM fromJson(Map<String, dynamic> json) => UserM(
      id: json['id'],
      name: json['name'],
      points: json['points'],
      organico: json['organico'],
      carton: json['carton'],
      plastico: json['plastico']);
}
