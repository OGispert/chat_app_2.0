import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chat_app_2/models/login_response.dart';
import 'package:chat_app_2/models/user.dart';
import 'package:chat_app_2/services/environments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  late User user;

  bool _authenticating = false;

  bool get authenticating => _authenticating;

  final _storage = FlutterSecureStorage();

  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    authenticating = true;

    final data = {'username': username, 'password': password};

    final response = await http.post(
      Uri.parse('${Environments.apiURL}/login'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    authenticating = false;

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    }

    return false;
  }

  Future<bool> register(String name, String username, String password) async {
    authenticating = true;

    final data = {'name': name, 'username': username, 'password': password};

    final response = await http.post(
      Uri.parse('${Environments.apiURL}/login/new'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    authenticating = false;

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

  static Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    final token = storage.read(key: 'token');
    return token;
  }

  static Future deleteToken() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> isLoggedId() async {
    final token = await _storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('${Environments.apiURL}/login/renew'),
      headers: {'Content-Type': 'application/json', 'x-token': token ?? ''},
    );

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    }
    logout();
    return false;
  }
}
