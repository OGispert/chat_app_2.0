import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String name;
  String username;
  bool isOnline;
  String uid;

  User({
    required this.name,
    required this.username,
    required this.isOnline,
    required this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    username: json["username"],
    isOnline: json["isOnline"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "isOnline": isOnline,
    "uid": uid,
  };
}
