import 'dart:convert';
import 'package:chat_app_2/models/message.dart';

MessagesResponse messagesResponseFromJson(String str) =>
    MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) =>
    json.encode(data.toJson());

class MessagesResponse {
  bool ok;
  List<Message> messages;

  MessagesResponse({required this.ok, required this.messages});

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      MessagesResponse(
        ok: json["ok"],
        messages: List<Message>.from(
          json["messages"].map((x) => Message.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}
