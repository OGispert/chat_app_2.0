import 'package:chat_app_2/services/auth_service.dart';
import 'package:chat_app_2/services/environments.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerState { online, offline, connecting }

class SocketService with ChangeNotifier {
  var _serverState = ServerState.connecting;
  late IO.Socket _socket;

  ServerState get serverState => _serverState;
  IO.Socket get socket => _socket;

  void connect() async {
    final token = await AuthService.getToken();

    // Dart client
    _socket = IO.io(Environments.socketURL, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token},
    });

    _socket.onConnect((_) {
      _serverState = ServerState.online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverState = ServerState.offline;
      notifyListeners();
    });

    // socket.on('new-message', (payload) {
    //   print('New Message: $payload');
    // });
  }

  void disconnect() {
    socket.disconnect();
  }
}
