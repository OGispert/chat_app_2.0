import 'package:chat_app_2/models/massages_response.dart';
import 'package:chat_app_2/models/message.dart';
import 'package:chat_app_2/models/user.dart';
import 'package:chat_app_2/services/auth_service.dart';
import 'package:chat_app_2/services/environments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late User receipient;

  Future<List<Message>> getChat(String userID) async {
    try {
      final response = await http.get(
        Uri.parse('${Environments.apiURL}/messages/$userID'),
        headers: {'x-token': await AuthService.getToken() ?? ''},
      );

      return messagesResponseFromJson(response.body).messages;
    } catch (error) {
      return [];
    }
  }
}
