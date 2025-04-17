import 'package:uuid/uuid.dart';

final uuid = Uuid().v4();

class User {
  User({required this.isOnline, required this.email, required this.name});

  final bool isOnline;
  final String email;
  final String name;
  final String uid = uuid;
}
